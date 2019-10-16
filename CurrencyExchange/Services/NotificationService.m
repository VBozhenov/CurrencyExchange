//
//  NotificationService.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 13/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "NotificationService.h"
#import <UserNotifications/UserNotifications.h>

@interface NotificationService () <UNUserNotificationCenterDelegate>
@end

@implementation NotificationService

+ (instancetype)sharedInstance
{
    static NotificationService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NotificationService alloc] init];

    });
    return instance;
}

- (void)registerService {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"Доступ есть");
                                  }
                              }];
    }
}

- (void)sendNotification:(Notification)notification {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = notification.title;
        content.body = notification.body;
        content.sound = [UNNotificationSound defaultSound];

        if (notification.imageURL) {
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image"
                                                                                                  URL:notification.imageURL
                                                                                              options:nil
                                                                                                error:nil];
            if (attachment) {
                content.attachments = @[attachment];
            }
        }
//
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone]
                                                             fromDate:notification.date];
        NSDateComponents *newComponents = [[NSDateComponents alloc] init];
        newComponents.calendar = calendar;
        newComponents.timeZone = [NSTimeZone defaultTimeZone];
        newComponents.month = components.month;
        newComponents.day = components.day;
        newComponents.hour = components.hour;
        newComponents.minute = components.minute;
        newComponents.second = components.second;


        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:false];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification"
                                                                              content:content trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:nil];
}

Notification NotificationMake(NSString* _Nullable title,
                              NSString* _Nonnull body,
                              NSDate* _Nonnull date,
                              NSURL * _Nullable  imageURL) {
    Notification notification;
    notification.title = title;
    notification.body = body;
    notification.date = date;
    notification.imageURL = imageURL;
    return notification;
}
@end
