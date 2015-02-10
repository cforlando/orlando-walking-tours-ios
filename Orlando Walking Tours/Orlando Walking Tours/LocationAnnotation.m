//
//  LocationAnnotation.m
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/10/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import "LocationAnnotation.h"
#import "HistoricLocation.h"

@implementation LocationAnnotation

-(id)initWithHistoricLocation:(HistoricLocation *)location {
    self = [super init];
    
    if (self) {
        self.title = location.locationTitle;
        self.coordinate = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
    }
    
    return self;
}

-(MKAnnotationView *)annotationView {
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"LocationAnnotation"];
    
    return annotationView;
}

@end
