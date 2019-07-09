//
//  Currency+CoreDataProperties.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 10/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//
//

#import "Currency+CoreDataProperties.h"

@implementation Currency (CoreDataProperties)

+ (NSFetchRequest<Currency *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Currency"];
}

@dynamic charCode;
@dynamic nominal;
@dynamic name;
@dynamic value;
@dynamic previous;
@dynamic isFavorite;

@end
