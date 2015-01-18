//
//  DetailViewController.m
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//


#import "DetailViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize btn_dontShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *) saveFilePath
{
    
    NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"PopupSettings"];
}

-(IBAction)dismiss
{
    [self removeFromView];
}
-(IBAction)dontShowAgain
{
    
    if ([btn_dontShow.titleLabel.text isEqualToString: @"Show On Launch"])
    {
        //save that the popup should be shown
        NSArray *values = [[NSArray alloc] initWithObjects:@"ShowPopup",nil];
        [values writeToFile:[self saveFilePath] atomically:YES];
    }
    else
    {
        //save that the popup shouldnt be shown
        NSArray *values = [[NSArray alloc] initWithObjects:@"DontShowPopup",nil];
        [values writeToFile:[self saveFilePath] atomically:YES];
    }
    
    [self removeFromView];
}

-(void)removeFromView
{
    [self.parent dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //path to popup settings
    NSString *myPath = [self saveFilePath];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    
    //check if the setings exist
    if (fileExists)
    {
        NSArray *values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        //check if the popups are set to hide
        if ([[values objectAtIndex:0] isEqualToString:@"DontShowPopup"])
        {
            //change the button text to show popups on launch
            [btn_dontShow setTitle:@"Show On Launch" forState:UIControlStateNormal];
            
        }
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
