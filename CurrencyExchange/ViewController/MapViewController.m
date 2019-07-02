//
//  MapViewController.m
//  CurrencyExchange
//
//  Created by Vladimir Bozhenov on 02/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    
    for (MKMapItem *item in self.mapItems) {
        [self setAnotation: item];
    }
    [self.view addSubview:self.mapView];

    
}

- (void) setAnotation:(MKMapItem*) mapItem {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(55.7, 37.6);
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
