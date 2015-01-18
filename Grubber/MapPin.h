//
//  MapPin.h
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *str_date;
@property (nonatomic, strong) NSString *str_tweet;
@property (nonatomic, strong) NSString *str_tweeter;
@property (nonatomic, strong) NSURL *url_picture;

-(id)initWithTweet:(NSString *)_tweet Tweeter:(NSString *)_tweeter
          ImageUrl:(NSURL *)_pictureUrl Date:(NSString *)_date
            Coords:(CLLocationCoordinate2D)_coords;


@end
