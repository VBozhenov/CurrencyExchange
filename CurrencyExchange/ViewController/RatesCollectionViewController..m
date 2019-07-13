//
//  RatesCollectionViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 05/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "RatesCollectionViewController.h"
#import "RatesCollectionViewCell.h"
#import "DetailedViewController.h"
#import <CoreData/CoreData.h>
#import "DataService.h"

@interface RatesCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *value;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchRates;
@property (nonatomic, strong) NSArray<Currency*>* currencies;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSPredicate *favoritePredicate;

@end

@implementation RatesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencies = [[DataService sharedInstance] getAllCurrencies];
    self.favoritePredicate = [NSPredicate predicateWithFormat:@"SELF.isFavorite == true"];
    
    [self setTitle:@"Currency rates"];
    [self.navigationController.navigationBar setPrefersLargeTitles:true];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake(([self.view bounds].size.width - 3) / 2,
                                 ([self.view bounds].size.height - 4) / 4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[RatesCollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.collectionView];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"All", @"Favorite"]];
    [self.segmentedControl setFrame:CGRectMake(5,
                                               [self.view bounds].size.height - 70,
                                               [self.view bounds].size.width - 10,
                                               50)];
    [self.segmentedControl setBackgroundColor:[UIColor blackColor]];
    [self.segmentedControl setSelectedSegmentIndex:1];
    [self.segmentedControl addTarget:self action:@selector(changeSegment) forControlEvents:(UIControlEventValueChanged)];
    
    [self.view addSubview:self.segmentedControl];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController setSearchResultsUpdater:self];
    [self.navigationItem setSearchController:self.searchController];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd]%@ OR SELF.charCode CONTAINS[cd]%@",
                                  searchController.searchBar.text,
                                  searchController.searchBar.text];
        self.searchRates = [self.rates filteredArrayUsingPredicate:predicate];
        [self.collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RatesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    if (self.searchController.isActive && [self.searchRates count] > 0) {
        
        if (self.segmentedControl.selectedSegmentIndex == 1) {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
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

-(void)changeSegment {
    [self.collectionView reloadData];
}

@end
