//
//  ViewController.m
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import "MapViewController.h"
#import "DataParser.h"
#import "PopOverViewController.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+MJPopupViewController.h"

@implementation MapViewController

@synthesize map_mapView, mka_selectedAnnotation, pc_popover, fppc_foodPopover, mary_pins, str_moreImage, str_foodImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //path to popup settings
    NSString *myPath = [self saveFilePath];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    
    //check if the setings exist
    if (fileExists)
    {
        NSArray *values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        //check if the popups are set to hide
        if (![[values objectAtIndex:0] isEqualToString:@"DontShowPopup"])
        {
            //show the info popup
            [self showInfoPopup];
        }
        
    }
    else
    {
        //show the info popup
        [self showInfoPopup];
    }


    // Do any additional setup after loading the view, typically from a nib.
    DataParser *datap = [[DataParser alloc] init];
    [datap fetchJson];
    mary_pins = [datap parseJson];

    
    NSBundle* myBundle = [NSBundle mainBundle];
    
    str_foodImage = [myBundle pathForResource:@"pin" ofType:@"png"];
    str_moreImage = [myBundle pathForResource:@"more" ofType:@"png"];
    
    [self.map_mapView setAnnotations:mary_pins];
    [self.map_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(43.6632245, -79.395480), MKCoordinateSpanMake(0.0501, 0.0501 )) animated:YES];
}

-(void)showInfoPopup
{
    //load the detail view controller
    DetailViewController *detailViewController = [[DetailViewController alloc]initWithNibName:@"PopupDetails" bundle:nil];
    
    //set the parent view controller (used to dismiss the view after)
    detailViewController.parent = self;
    
    //show the app info popup
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
}

//return the path of the popup settings file
- (NSString *) saveFilePath
{
    
    NSArray *path =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"PopupSettings"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - ADClusterMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ADClusterableAnnotation"];
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADClusterableAnnotation"];
        pinView.image = [[UIImage alloc] initWithContentsOfFile:str_foodImage];
        pinView.canShowCallout = NO;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}
- (MKAnnotationView *)mapView:(ADClusterMapView *)mapView viewForClusterAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ADMapCluster"];
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADMapCluster"];
        pinView.image = [[UIImage alloc] initWithContentsOfFile:str_moreImage];
        pinView.canShowCallout = YES;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}



- (NSInteger)numberOfClustersInMapView:(ADClusterMapView *)mapView {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 10;
    }
    else
    {
        return 15;
    }
}

- (double)clusterDiscriminationPowerForMapView:(ADClusterMapView *)mapView {
    return 1;
}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotationView
{
    ADClusterAnnotation *annotation = annotationView.annotation;
    
    if ([annotationView.annotation isKindOfClass:[MKUserLocation class]] || annotation.originalAnnotations.count != 1);
    else
    {
        MapPin *originalAnnotation = (MapPin *)annotation.originalAnnotations[0];
        
        PopOverViewController *controller = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
        
        [self.parentViewController addChildViewController:controller];

        // it's useful to have property in your view controller for whatever data it needs to present the annotation's details
        controller.currentPin = originalAnnotation;
        
        
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller delegate:self];
        
        popover.border = NO;
        popover.tint = FPPopoverRedTint;
        
        popover.contentSize = CGSizeMake((int)controller.view.frame.size.width, (int)controller.view.frame.size.height);
        
        
        popover.arrowDirection = FPPopoverArrowDirectionVertical;
        [popover presentPopoverFromView:annotationView];
        
        fppc_foodPopover = popover;
        
        mka_selectedAnnotation = annotationView;

    }
}


@end
