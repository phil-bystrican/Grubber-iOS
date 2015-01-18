//
//  PopOverViewController.h
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPin.h"
#import "FPPopoverController.h"
#import <MessageUI/MessageUI.h>

@interface PopOverViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *txtvw_info;
@property (nonatomic, strong) IBOutlet UILabel *lbl_title;
@property (nonatomic, strong) IBOutlet UILabel *lbl_date;

@property (nonatomic, strong) MapPin *currentPin;

@property (nonatomic, strong) FPPopoverController *popOver;

-(IBAction)getTurnByTurn:(id)sender;

@end
