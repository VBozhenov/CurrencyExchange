//
//  Currency.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 25/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Currency : NSObject

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSNumber *value;

- (instancetype)initWithFlag: (NSString*) flag
                        name: (NSString*) name
                       value: (NSNumber*) value;

@end

NS_ASSUME_NONNULL_END
