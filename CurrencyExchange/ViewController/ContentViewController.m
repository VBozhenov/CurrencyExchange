//
//  ContentViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 12/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ContentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(32,
                                                                       32,
                                                                       [UIScreen mainScreen].bounds.size.width - 64,
                                                                       [UIScreen mainScreen].bounds.size.height - 200)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.cornerRadius = 8.0;
        self.imageView.clipsToBounds = YES;
        [self.view addSubview:self.imageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.,
                                                                      [UIScreen mainScreen].bounds.size.height/2 + 300,
                                                                      200,
                                                                      80)];
        self.contentLabel.font = [UIFont systemFontOfSize:20
                                                   weight:UIFontWeightSemibold];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.contentLabel];
    }
    return self;
}

- (void)setContentText:(NSString *)contentText {
    [self.contentLabel setText:contentText];
}

- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
}

@end

