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

@interface RatesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchRates;

@end

@implementation RatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController setSearchResultsUpdater:self];
    [self.navigationItem setSearchController:self.searchController];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 60;
    
    [self.tableView registerClass:[CurrencyTableViewCell class]
           forCellReuseIdentifier:@"CurrencyTableViewCell"];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.tableView setTableFooterView:[UIView alloc]];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Greetings!"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(barButtonTaped)];
    barButtonItem.image = [UIImage imageNamed:@"collection"];
    self.navigationItem.rightBarButtonItem = barButtonItem;    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd]%@ OR SELF.charCode CONTAINS[cd]%@",
                                  searchController.searchBar.text,
                                  searchController.searchBar.text];
        self.searchRates = [self.rates filteredArrayUsingPredicate:predicate];
        [self.tableView reloadData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        return self.searchRates.count;
    }
    
    return self.rates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyTableViewCell"];
    
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        [cell setupCellWithCurrency:self.searchRates[indexPath.row]];
    } else {
        [cell setupCellWithCurrency:self.rates[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Currency *currency = [[Currency alloc]init];

    if (self.searchController.isActive && [self.searchRates count] > 0) {
        currency = [self.searchRates objectAtIndex:indexPath.row];
    } else {
        currency = [self.rates objectAtIndex:indexPath.row];
    }

    DetailedViewController *detailedViewController = [[DetailedViewController alloc] init];
    detailedViewController.currency = currency;
    [self.searchController setActive:false];
    [self.navigationController pushViewController:detailedViewController
                                         animated:true];
}

-(void)barButtonTaped {
   
    RatesCollectionViewController *ratesCollectionViewController = [[RatesCollectionViewController alloc] init];
    ratesCollectionViewController.rates = self.rates;
    [self.navigationController pushViewController:ratesCollectionViewController
                                         animated:true];
}
@end
