//
//  PopOverViewController.m
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import "PopOverViewController.h"

@implementation PopOverViewController

@synthesize currentPin, popOver, lbl_title, txtvw_info, lbl_date;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lbl_title.text = currentPin.str_tweeter;
    txtvw_info.text = currentPin.str_tweet;
    lbl_date.text = currentPin.str_date;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)getTurnByTurn:(id)sender
{
    
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        
        MKPlacemark *placemark = [[MKPlacemark alloc]  initWithCoordinate:CLLocationCoordinate2DMake(currentPin.coordinate.latitude, currentPin.coordinate.longitude) addressDictionary:nil];
        
        // Create a map item for the geocoded address to pass to Maps app
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:[NSString stringWithFormat:@"@%@, %@", currentPin.str_tweeter, currentPin.str_tweet]];
        
        // Set the directions mode to "Driving"
        // Can use MKLaunchOptionsDirectionsModeWalking instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    }
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
