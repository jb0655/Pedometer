//
//  StepManager.m
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/13.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import "StepManager.h"

@interface StepManager ()

@property (nonatomic) int totalStep, intervalStep, imageNum;

@end

@implementation StepManager

@synthesize totalStep = _totalStep;
@synthesize intervalStep = _intervalStep;
@synthesize imageNum = _imageNum;
@synthesize pictureChangeFlag = _pictureChangeFlag;

- (int)totalStep
{
    if (!_totalStep) { _totalStep = 0; }
    return _totalStep;
}

- (int)intervalStep
{
    if (!_intervalStep) { _intervalStep = 0; }
    return _intervalStep;
}

-(int)imageNum
{
    if (!_imageNum) { _imageNum = 0; }
    return _imageNum;
}

- (BOOL)pictureChangeFlag
{
    if (!_pictureChangeFlag) { _pictureChangeFlag = false; }
    return _pictureChangeFlag;
}

//歩数管理
- (int)countCheck:(accPos)accPos
{
    //加速度情報が閾値に達していたとき
    if (accPos.x > 1.0 || accPos.y > 1.0 || accPos.z > 1.0) {
        self.totalStep++;
        self.intervalStep++;
        //画像変更フラグ判断
        //画像を変更したい歩数単位毎に画像変更フラグをたてる（現在：100）
        if (self.totalStep > 0 && self.totalStep % 100 == 0) {
            self.imageNum += 10;
            self.pictureChangeFlag = true;
        }
    };
    return self.intervalStep;
}

//表示イメージのタイトル番号返却
- (int)imageCheck
{
    self.pictureChangeFlag = false;
    return self.imageNum;
}

- (void)resetInterval
{
    self.intervalStep = 0;
}
@end
