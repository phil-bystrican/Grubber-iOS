//
//  DetailViewController.h
//  Grubber
//
//  Created by Phil Bystrican on 2014-09-20.
//  Copyright (c) 2014 Phil Bystrican Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) UIViewController *parent;

@property (nonatomic, strong) IBOutlet  UIButton *btn_dontShow;

-(IBAction)dismiss;
-(IBAction)dontShowAgain;


@end
