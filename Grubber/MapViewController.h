//
//  ViewController.h
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"
#import "FPPopoverController.h"
#import "ADClusterMapView.h"

@interface MapViewController : UIViewController <ADClusterMapViewDelegate, UIPopoverControllerDelegate, FPPopoverControllerDelegate>
{
    IBOutlet ADClusterMapView *map_mapView;
}

@property (nonatomic, strong) IBOutlet ADClusterMapView *map_mapView;
@property (nonatomic, strong) UIPopoverController *pc_popover;
@property (nonatomic, strong) NSMutableArray *mary_pins;

@property (nonatomic, strong) FPPopoverController *fppc_foodPopover;
@property (nonatomic, strong) MKAnnotationView *mka_selectedAnnotation;
@property (nonatomic, strong) NSString *str_foodImage;
@property (nonatomic, strong) NSString *str_moreImage;


@end

