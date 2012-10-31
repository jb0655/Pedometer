//
//  MainViewController.h
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/12.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MainViewController : UIViewController

- (void)positionCheck;
- (void)pictureDisplay:(int)imageNum;
- (void)stepDisplay:(int)stemNum;
- (void)resetAlert;
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)infoViewModal;

@end
