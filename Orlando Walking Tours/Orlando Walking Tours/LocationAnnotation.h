//
//  LocationAnnotation.h
//  Orlando Walking Tours
//
//  Created by Andrew Kozlik on 2/10/15.
//  Copyright (c) 2015 Andrew Kozlik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class HistoricLocation;

@interface LocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

-(id)initWithHistoricLocation:(HistoricLocation *)location;
-(MKAnnotationView *)annotationView;

@end
