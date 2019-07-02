//
//  MapViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 02/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationService.h"


@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) LocationService *service;
@property (nonatomic, strong) CLLocation *location;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    
    self.service = [[LocationService alloc] init];
    
    
    [self.view addSubview:self.mapView];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationWasUpdate:) name:kLocationUpdate object:nil];
}

- (void)locationWasUpdate:(NSNotification*)notification {
    self.location = notification.object;
    
    for (MKMapItem *item in self.mapItems) {
        [self setAnotation: item
                  location:self.location];
    }
    
}

- (void) setAnotation:(MKMapItem*) mapItem location:(CLLocation*) location {
    CLLocationCoordinate2D coordinate = location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);

    [self.mapView setRegion:region];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = mapItem.name;
    annotation.subtitle = mapItem.phoneNumber;
    annotation.coordinate = mapItem.placemark.location.coordinate;
    
    [self.mapView addAnnotation:annotation];
};

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"Marker";
    MKMarkerAnnotationView *marker = (MKMarkerAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!marker) {
        marker = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        marker.canShowCallout = true;
        marker.calloutOffset = CGPointMake(-5, 5);
        marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    marker.annotation = annotation;
    
    return marker;
};

@end
