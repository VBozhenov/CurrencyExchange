//
//  EditViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "EditViewController.h"
#import "Data.h"

@interface EditViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.tableView setTableFooterView:[UIView alloc]];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"My Currencies" : @"Available Currencies";
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [[Data sharedObject].myCurrencies count] : [[Data sharedObject].currenciesToAdd count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"CurrencyCell"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [Data sharedObject].myCurrencies[indexPath.row].fullName;
    } else {
        cell.textLabel.text = [Data sharedObject].currenciesToAdd[indexPath.row].fullName;
    }

    return cell;
}

#pragma mark - UITableViewDelegate -

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *act = [[UITableViewRowAction alloc] init];
    if (indexPath.section == 0) {
        act = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                 title:@"Delete"
                                               handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [[Data sharedObject].currenciesToAdd addObject:[Data sharedObject].myCurrencies[indexPath.row]];
            [[Data sharedObject].myCurrencies removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
        }];
    } else {
        act = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                 title:@"Add"
                                               handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [[Data sharedObject].myCurrencies addObject:[Data sharedObject].currenciesToAdd[indexPath.row]];
            [[Data sharedObject].currenciesToAdd removeObjectAtIndex:indexPath.row];
            [tableView reloadData];
            [act setBackgroundColor:[UIColor blueColor]];
        }];
    }
    return @[act];
}

@end
