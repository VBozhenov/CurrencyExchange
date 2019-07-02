//
//  LocationService.h
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 02/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationUpdate @"kLocationUpdate"

@interface LocationService : NSObject

@property (strong, nonatomic) CLLocation *currentLocation;

@end
