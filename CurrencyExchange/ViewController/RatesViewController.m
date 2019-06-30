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

@interface RatesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    [self setTitle:@"Currency rates"];
    [self.navigationController.navigationBar setPrefersLargeTitles:true];
    
    
    self.tableView.rowHeight = 60;
    
    [self.tableView registerClass:[CurrencyTableViewCell class]
           forCellReuseIdentifier:@"CurrencyTableViewCell"];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.tableView setTableFooterView:[UIView alloc]];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return section == 0 ? @"My Currencies" : @"Available Currencies";
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyTableViewCell"];
    [cell setupCellWithCurrency:self.rates[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Currency *currency = [self.rates objectAtIndex:indexPath.row];
    DetailedViewController *detailedViewController = [[DetailedViewController alloc] init];
    detailedViewController.currency = currency;
    [self.navigationController pushViewController:detailedViewController animated:true];
}

@end
