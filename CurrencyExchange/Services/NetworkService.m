//
//  NetworkService.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 28/06/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "NetworkService.h"

#define MAIN_URL @"https://www.cbr-xml-daily.ru/daily_json.js"

@implementation NetworkService

+ (instancetype)sharedInstance {
    static NetworkService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkService alloc] init];
    });
    return instance;
}

- (void)getRates:(void (^)(NSArray<Currency*> *rates))completion {
    [self load:MAIN_URL withCompletion:^(id  _Nullable result) {
        NSArray<Currency*>* currencies = [[DataService sharedInstance] getAllCurrencies];
        NSDictionary *dict = result;
        [dict[@"Valute"] enumerateKeysAndObjectsUsingBlock:^(NSString *key,
                                                             NSDictionary *obj,
                                                             BOOL * _Nonnull stop) {
            NSDictionary *rate = @{@"charCode": key,
                                   @"nominal": [obj objectForKey:@"Nominal"],
                                   @"name": [obj objectForKey:@"Name"],
                                   @"value": [obj objectForKey:@"Value"],
                                   @"previous": [obj objectForKey:@"Previous"]};
            if (currencies.count == 0) {
                [[DataService sharedInstance] createCurrencyWithCharCode:[rate valueForKey:@"charCode"]
                                                             withNominal:[rate valueForKey:@"nominal"]
                                                                withName:[rate valueForKey:@"name"]
                                                               withValue:[rate valueForKey:@"value"]
                                                            withPrevious:[rate valueForKey:@"previous"]
                                                          withIsFavorite:false];
            } else {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.charCode == %@", [rate valueForKey:@"charCode"]];
                Currency *result = [[currencies filteredArrayUsingPredicate:predicate] firstObject];
                result.value = [[rate valueForKey:@"value"] doubleValue];
                result.previous= [[rate valueForKey:@"previous"] doubleValue];
                [[DataService sharedInstance] save];
            }
            
        }];
        completion([[DataService sharedInstance] getAllCurrencies]);
    }];
}

- (void)load:(NSString*)address withCompletion:(void (^)(id _Nullable result))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:address]
                                 completionHandler:^(NSData * _Nullable data,
                                                     NSURLResponse * _Nullable response,
                                                     NSError * _Nullable error) {
                                     if (!error) {
                                         completion([NSJSONSerialization JSONObjectWithData:data
                                                                                    options:NSJSONReadingMutableContainers
                                                                                      error:nil]);
                                     }
                                 }] resume] ;
}


@end
