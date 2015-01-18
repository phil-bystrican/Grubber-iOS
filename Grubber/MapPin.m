//
//  MapPin.m
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin

@synthesize str_tweet, url_picture, coordinate, str_tweeter, title, str_date;

-(id)initWithTweet:(NSString *)_tweet Tweeter:(NSString *)_tweeter
          ImageUrl:(NSURL *)_pictureUrl Date:(NSString *)_date
            Coords:(CLLocationCoordinate2D)_coords
{
    self = [super init];
    if(self)
    {
        self.title = _tweeter;
        self.str_tweet = _tweet;
        self.str_tweeter = _tweeter;
        self.url_picture = _pictureUrl;
        self.coordinate = _coords;
        self.str_date = _date;
    }
    
    return self;
}



@end
