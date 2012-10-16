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
- (void)resetButton:(UIButton *)sender;
- (void)infoButton:(UIButton *)sender;

@end
