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

- (void)getRates:(void (^)(NSArray *rates))completion {
    [self load:MAIN_URL withCompletion:^(id  _Nullable result) {
        NSDictionary *dict = result;
        NSMutableArray *resultObjects = [NSMutableArray new];
        [dict[@"Valute"] enumerateKeysAndObjectsUsingBlock:^(NSString *key,
                                                             NSDictionary *obj,
                                                             BOOL * _Nonnull stop) {
            NSDictionary *rate = @{@"charCode": key,
                                   @"nominal": [obj objectForKey:@"Nominal"],
                                   @"name": [obj objectForKey:@"Name"],
                                   @"value": [obj objectForKey:@"Value"],
                                   @"previous": [obj objectForKey:@"Previous"]};
            Currency *model = [[Currency alloc] initFromDictionary:rate];
            [resultObjects addObject:model];
        }];
        completion(resultObjects);
    }];
}

- (void)load:(NSString*)address withCompletion:(void (^)(id _Nullable result))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:address]
                                 completionHandler:^(NSData * _Nullable data,
                                                     NSURLResponse * _Nullable response,
                                                     NSError * _Nullable error) {
                                     completion([NSJSONSerialization JSONObjectWithData:data
                                                                                options:NSJSONReadingMutableContainers
                                                                                  error:nil]);
    }] resume] ;
}


@end
