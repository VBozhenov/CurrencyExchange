//
//  Currency+CoreDataProperties.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 10/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//
//

#import "Currency+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *charCode;
@property (nonatomic) int16_t nominal;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double value;
@property (nonatomic) double previous;
@property (nonatomic) BOOL isFavorite;

@end

NS_ASSUME_NONNULL_END
