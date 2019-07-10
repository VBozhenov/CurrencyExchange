//
//  RatesViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "RatesViewController.h"
#import "CurrencyTableViewCell.h"
#import "DetailedViewController.h"
#import "RatesCollectionViewController.h"
#import "DataService.h"
#import <CoreData/CoreData.h>

@interface RatesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchRates;
@property (nonatomic, strong) NSArray<Currency*>* currencies;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSPredicate *favoritePredicate;

@end

@implementation RatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencies = [[DataService sharedInstance] getAllCurrencies];
    self.favoritePredicate = [NSPredicate predicateWithFormat:@"SELF.isFavorite == true"];

    [self setTitle:@"Currency rates"];
    [self.navigationController.navigationBar setPrefersLargeTitles:true];

    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController setSearchResultsUpdater:self];
    [self.navigationItem setSearchController:self.searchController];
    
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"All", @"Favorite"]];
    [self.segmentedControl setFrame:CGRectMake(5,
                                               [self.view bounds].size.height - 70,
                                               [self.view bounds].size.width - 10,
                                               50)];
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.segmentedControl addTarget:self action:@selector(changeSegment) forControlEvents:(UIControlEventValueChanged)];

    [self.view addSubview:self.segmentedControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   [self.view bounds].size.width,
                                                                   [self.view bounds].size.height - 70) style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 60;
    
    [self.tableView registerClass:[CurrencyTableViewCell class]
           forCellReuseIdentifier:@"CurrencyTableViewCell"];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.tableView setTableFooterView:[UIView alloc]];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"!"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(barButtonTaped)];
    barButtonItem.image = [UIImage imageNamed:@"collection"];
    self.navigationItem.rightBarButtonItem = barButtonItem;    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd]%@ OR SELF.charCode CONTAINS[cd]%@",
                                  searchController.searchBar.text,
                                  searchController.searchBar.text];
        self.searchRates = [self.rates filteredArrayUsingPredicate:searchPredicate];
        [self.tableView reloadData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            return [self.searchRates filteredArrayUsingPredicate:self.favoritePredicate].count;
        } else {
            return self.searchRates.count;
        }
    }
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        return [self.rates filteredArrayUsingPredicate:self.favoritePredicate].count;
    } else {
        return self.rates.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyTableViewCell"];
    
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        
        if (self.segmentedControl.selectedSegmentIndex == 1) {
//            currency = [[self.searchRates filteredArrayUsingPredicate:self.predicate] objectAtIndex:indexPath.row];
            [cell setupCellWithCurrency:[[self.searchRates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row]];
        } else {
            [cell setupCellWithCurrency:self.searchRates[indexPath.row]];
        }
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            [cell setupCellWithCurrency:[[self.rates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row]];
        } else {
            [cell setupCellWithCurrency:self.rates[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Currency *currency = [[Currency alloc]init];

    if (self.searchController.isActive && [self.searchRates count] > 0) {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            currency = [[self.searchRates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row];
        } else {
            currency = [self.searchRates objectAtIndex:indexPath.row];
        }
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            currency = [[self.rates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row];
        } else {
            currency = [self.rates objectAtIndex:indexPath.row];
        }
    }

    DetailedViewController *detailedViewController = [[DetailedViewController alloc] init];
    detailedViewController.currency = currency;
    [self.navigationController pushViewController:detailedViewController
                                         animated:true];
    [self.searchController setActive:false];

}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action = [[UITableViewRowAction alloc]init];
    
    Currency *currency = [[Currency alloc]init];
    
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            currency = [[self.searchRates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row];
        } else {
            currency = [self.searchRates objectAtIndex:indexPath.row];
        }
    } else {
        if (self.segmentedControl.selectedSegmentIndex == 1) {
            currency = [[self.rates filteredArrayUsingPredicate:self.favoritePredicate] objectAtIndex:indexPath.row];
        } else {
            currency = [self.rates objectAtIndex:indexPath.row];
        }
    }
    
    if (currency.isFavorite) {
        action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Remove from Favorites" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.charCode == %@", currency.charCode];
            Currency *result = [[self.currencies filteredArrayUsingPredicate:predicate] firstObject];
            result.isFavorite = false;
            currency.isFavorite = false;
            [[DataService sharedInstance] save];
            [tableView reloadData];
        }];
    } else {
        action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Add to Favorites" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.charCode == %@", currency.charCode];
            Currency *result = [[self.currencies filteredArrayUsingPredicate:predicate] firstObject];
            result.isFavorite = true;
            currency.isFavorite = true;
            [[DataService sharedInstance] save];
            [tableView reloadData];
        }];
        
        [action setBackgroundColor:[UIColor blueColor]];
    }
    
    NSArray* actionArray = @[action];
    return actionArray;
}

-(void)barButtonTaped {
   
    RatesCollectionViewController *ratesCollectionViewController = [[RatesCollectionViewController alloc] init];
    ratesCollectionViewController.rates = self.rates;
    [self.navigationController pushViewController:ratesCollectionViewController
                                         animated:true];
}

-(void)changeSegment {
    [self.tableView reloadData];
}

@end
