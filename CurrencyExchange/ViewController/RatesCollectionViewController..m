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

@interface RatesCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *value;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray<Currency*> *searchRates;

@end

@implementation RatesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.collectionView registerClass:[RatesCollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.collectionView];
    
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
        return self.searchRates.count;
    }
    
    return self.rates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RatesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    [cell setBackgroundColor:[UIColor lightGrayColor]];
    
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        [cell setupCellWithCurrency:self.searchRates[indexPath.row]];
    } else {
        [cell setupCellWithCurrency:self.rates[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    Currency *currency = [[Currency alloc]init];
        
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        currency = [self.searchRates objectAtIndex:indexPath.row];
    } else {
        currency = [self.rates objectAtIndex:indexPath.row];
    }
    
    DetailedViewController *detailedViewController = [[DetailedViewController alloc] init];
    detailedViewController.currency = currency;
    [self.navigationController pushViewController:detailedViewController
                                         animated:true];
    [self.searchController setActive:false];
}


@end
