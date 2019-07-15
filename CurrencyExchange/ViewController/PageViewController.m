//
//  PageViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 12/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "PageViewController.h"
#import "TabBar.h"

#define CONTENT_COUNT 4

@interface PageViewController ()
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *content;
@end

@implementation PageViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createContent];

    self.dataSource = self;
    self.delegate = self;
    ContentViewController *startViewController = [self viewControllerAtIndex:0];
    [self setViewControllers:@[startViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];

    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                       self.view.bounds.size.height - 50.0,
                                                                       self.view.bounds.size.width,
                                                                       50.0)];
    self.pageControl.numberOfPages = CONTENT_COUNT;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:self.pageControl];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width - 100.0,
                                       self.view.bounds.size.height - 200.0,
                                       100.0,
                                       50.0);
    [self.nextButton addTarget:self action:@selector(nextButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton setTintColor:[UIColor blackColor]];
    [self updateButtonWithIndex:0];
    [self.view addSubview:self.nextButton];
}

- (void)createContent {
    self.images = [NSArray arrayWithObjects:[UIImage imageNamed:@"1"],
                   [UIImage imageNamed:@"2"],
                   [UIImage imageNamed:@"3"],
                   [UIImage imageNamed:@"4"],
                   nil];
    self.content = [NSArray arrayWithObjects:@"КОНВЕРТЕР ВАЛЮТ",
                    @"ТЕКУЩИЕ КОТИРОВКИ",
                    @"ИЗБРАННОЕ",
                    @"БЛИЖАЙШИЕ ОБМЕННЫЕ ПУНКТЫ",
                    nil];
}


- (ContentViewController *)viewControllerAtIndex:(int)index {
    if (index < 0 || index >= CONTENT_COUNT) {
        return nil;
    }
    ContentViewController *contentViewController = [[ContentViewController alloc] init];
    [contentViewController setContentText:[self.content objectAtIndex:index]];
    [contentViewController setImage:[self.images objectAtIndex:index]];
    [contentViewController setIndex: index];
    return contentViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        int index = ((ContentViewController *)[pageViewController.viewControllers firstObject]).index;
        self.pageControl.currentPage = index;
        [self updateButtonWithIndex:index];
    }
}

- (void)updateButtonWithIndex:(int)index {
    switch (index) {
        case 0:
        case 1:
        case 2:
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
            self.nextButton.tag = 0;
            break;
        case 3:;
            [self.nextButton setTitle:@"Done" forState:UIControlStateNormal];
            self.nextButton.tag = 1;
            break;
        default:
            break;
    }
}

- (void)nextButtonDidTap:(UIButton *)sender
{
    int index = ((ContentViewController *)[self.viewControllers firstObject]).index;
    if (sender.tag) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_start"];
        [self dismissViewControllerAnimated:YES completion:nil];
        TabBar *tabBar = [[TabBar alloc] init];
        [self.navigationController pushViewController: tabBar
                                             animated:true];
    } else {
        __weak typeof(self) weakSelf = self;
        [self setViewControllers:@[[self viewControllerAtIndex:index+1]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            weakSelf.pageControl.currentPage = index+1;
            [weakSelf updateButtonWithIndex:index+1];
        }];
    }
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = ((ContentViewController *)viewController).index;
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    int index = ((ContentViewController *)viewController).index;
    index++;
    return [self viewControllerAtIndex:index];
}

@end
