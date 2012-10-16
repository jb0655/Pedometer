//
//  InfoViewController.m
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/13.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(15.0, 410.0, 75, 40);
    back.backgroundColor= [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:10.0] forState:UIControlStateNormal];
    back.titleLabel.font = [ UIFont fontWithName:@"Helvetica-Bold" size:24 ];
    [back addTarget:self action:@selector(dismissInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dismissInfoView
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
