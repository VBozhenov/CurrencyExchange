//
//  DataService.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 09/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "DataService.h"
#import <CoreData/CoreData.h>

@interface DataService ()

@property (nonatomic, strong) NSPersistentContainer *persistantContainer;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation DataService

+ (instancetype)sharedInstance {
    static DataService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataService alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    self.persistantContainer = [[NSPersistentContainer alloc] initWithName:@"Currency"];
    [self.persistantContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *descroption, NSError * error) {
        if (error != nil) {
            NSLog(@"Core data init error");
            abort();
        }
        self.context = self.persistantContainer.viewContext;
    }];
}

- (void)createCurrencyWithCharCode:(NSString*)charCode
                       withNominal:(NSNumber*)nominal
                          withName:(NSString*)name
                         withValue:(NSNumber*)value
                      withPrevious:(NSNumber*)previous
                    withIsFavorite:(BOOL)isFavorite {
    Currency *currency = [NSEntityDescription insertNewObjectForEntityForName:@"Currency" inManagedObjectContext:self.context];
    [currency setValue:charCode forKey:@"charCode"];
    [currency setValue:nominal forKey:@"nominal"];
    [currency setValue:name forKey:@"name"];
    [currency setValue:value forKey:@"value"];
    [currency setValue:previous forKey:@"previous"];
    [currency setValue:[NSNumber numberWithBool:isFavorite] forKey:@"isFavorite"];
    [self save];
}

- (NSArray*)getAllCurrencies {
    NSFetchRequest *requst = [NSFetchRequest fetchRequestWithEntityName:@"Currency"];
    NSError *error;
    
    NSArray *resutls = [self.context executeFetchRequest:requst error:&error];
    if (error && !resutls) {
        NSLog(@"Error fetching.");
    }
    
    return resutls;
}

- (void)save {
    NSError *error;
    if (![self.context save:&error]) {
        NSAssert(false, @"Error context save.");
    }
}


@end
