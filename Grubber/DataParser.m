//
//  DataParser.m
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import "DataParser.h"
#import "MapPin.h"

@implementation DataParser

-(void)fetchJson
{
    NSString *str_jsonLocation = @"http://grubber.me/tweets.json";
    NSURL  *url_json = [NSURL URLWithString:str_jsonLocation];
    NSData *dta_jsonData = [NSData dataWithContentsOfURL:url_json];
    
    if (dta_jsonData)
    {
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        //path to the json file
//        NSString *jsonFilePath = [path stringByAppendingPathComponent:@"tweets.json"];
//        NSLog(@"%@", jsonFilePath);
//        [dta_jsonData writeToFile:jsonFilePath atomically:YES];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *jsonFilePath = [documentsDirectory stringByAppendingPathComponent:@"tweets.json"];
        
        [dta_jsonData writeToFile:jsonFilePath atomically:YES];
    }
    else
    {
        NSLog(@"NO DATA");
    }
}

-(NSMutableArray *)parseJson
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *jsonFilePath = [documentsDirectory stringByAppendingPathComponent:@"tweets.json"];
    
    //load the json from the file into a string
    NSString* str_jsonData = [NSString stringWithContentsOfFile:jsonFilePath encoding:NSUTF8StringEncoding error:nil];
    NSData *dta_jsonData = [str_jsonData dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonFilePath);
    NSLog(@"Data %@", str_jsonData);
    
    
    
    NSArray *ary_data = [NSJSONSerialization JSONObjectWithData:dta_jsonData options:kNilOptions error:nil];
    
    NSMutableArray *mary_mapPins = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < ary_data.count; i++)
    {
        
        NSDictionary *dict_currentPinData = [ary_data objectAtIndex:i];
        NSString *str_tweet = [dict_currentPinData objectForKey:@"tweet_text"];
        NSString *str_tweeter = [dict_currentPinData objectForKey:@"tweet_name"];
        str_tweeter = [NSString stringWithFormat:@"@%@", str_tweeter];
        NSString *str_pictureLocation = [dict_currentPinData objectForKey:@"tweet_img"];
        NSURL *url_pictureLocation = [[NSURL alloc]initWithString:str_pictureLocation];
        NSString *str_latitude = [dict_currentPinData objectForKey:@"tweet_lat"];
        NSString *str_longitude = [dict_currentPinData objectForKey:@"tweet_long"];
        NSString *str_tweetDateData = [dict_currentPinData objectForKey:@"tweet_date"];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSNumber *nsnum_latitude = [formatter numberFromString:str_latitude];
        NSNumber *nsnum_longitude = [formatter numberFromString:str_longitude];
        NSNumber *nsnum_date = [formatter numberFromString:str_tweetDateData];
        
        NSCalendar *c = [NSCalendar currentCalendar];
        NSDate *d1 = [NSDate date];
        NSDate *d2 = [NSDate dateWithTimeIntervalSince1970:nsnum_date.intValue];
        NSDateComponents *components = [c components:NSCalendarUnitHour fromDate:d2 toDate:d1 options:0];
        
        NSInteger nsint_hoursSinceEvent = components.hour;
        NSString *str_tweetdate = @"";
        if (nsint_hoursSinceEvent > 24) {
            if (nsint_hoursSinceEvent/24 == 1)
            {
                str_tweetdate = [NSString stringWithFormat:@"%d day ago", (nsint_hoursSinceEvent/24)];
            }
            else
            {
                str_tweetdate = [NSString stringWithFormat:@"%d days ago", (nsint_hoursSinceEvent/24)];
            }
        }
        else
        {
            if (nsint_hoursSinceEvent == 1)
            {
                str_tweetdate = [NSString stringWithFormat:@"%d hour ago", nsint_hoursSinceEvent];
            }
            else
            {
                str_tweetdate = [NSString stringWithFormat:@"%d hours ago", nsint_hoursSinceEvent];
            }
        }

        
        CLLocationCoordinate2D coords_foodCoords = CLLocationCoordinate2DMake(nsnum_latitude.doubleValue ,nsnum_longitude.doubleValue);
        
        MapPin *pn_currentPin = [[MapPin alloc] initWithTweet:str_tweet Tweeter:str_tweeter ImageUrl:url_pictureLocation Date:str_tweetdate Coords:coords_foodCoords];
        
        [mary_mapPins addObject:pn_currentPin];
    }
    

    return mary_mapPins;
}


@end
