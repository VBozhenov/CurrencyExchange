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
    [self.collectionView registerClass:[UICollectionViewCell class]
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

//    self.name.text = nil;
//    self.value.text = nil;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    self.name.text = nil;
//    self.value.text = nil;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    RatesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    
    NSArray<Currency*> *data = [[NSArray alloc] init];
    
    if (self.searchController.isActive && [self.searchRates count] > 0) {
        data = self.searchRates;
//        [cell setupCellWithCurrency:self.searchRates[indexPath.row]];
    } else {
        data = self.rates;
//        [cell setupCellWithCurrency:self.rates[indexPath.row]];
    }
    
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                          8,
                                                          [cell bounds].size.width - 16,
                                                          80)];
    [self.name setTextAlignment:NSTextAlignmentCenter];
    [self.name setNumberOfLines:0];
    [self.name setFont:[UIFont systemFontOfSize:15
                                         weight:UIFontWeightThin]];
    self.name.text = [NSString stringWithFormat:@"%@ %@",
                      data[indexPath.row].nominal,
                      data[indexPath.row].name];

    [cell addSubview:self.name];

    self.value = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                           [cell bounds].size.height - 100,
                                                           [cell bounds].size.width - 16,
                                                           80)];
    [self.value setTextAlignment:NSTextAlignmentCenter];
    [self.value setNumberOfLines:0];
    [self.value setFont:[UIFont systemFontOfSize:15
                                          weight:UIFontWeightBold]];
    self.value.text = [NSString stringWithFormat:@"%.4f",
                       [data[indexPath.row].value floatValue]];

    [cell addSubview:self.value];
    
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
