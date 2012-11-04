//
//  StepManager.m
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/13.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import "StepManager.h"

@interface StepManager ()

@property (nonatomic) int totalStep;

@end

@implementation StepManager

@synthesize totalStep = _totalStep;
@synthesize intervalStep = _intervalStep;
@synthesize imageNum = _imageNum;
@synthesize pictureChangeFlag = _pictureChangeFlag;

- (BOOL)pictureChangeFlag
{
    if (!_pictureChangeFlag) { _pictureChangeFlag = false; }
    return _pictureChangeFlag;
}

//NSUserDefaults読み込み
- (void)readUserDefaults
{
    //初回のみ初期値設定
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"0" forKey:@"totalStep"];
    [defaults setObject:@"0" forKey:@"intervalStep"];
    [defaults setObject:@"0" forKey:@"imageNum"];
    [userDefaults registerDefaults:defaults];
    
    //各種設定値読み込み
    self.totalStep = [userDefaults integerForKey:@"totalStep"];
    self.intervalStep = [userDefaults integerForKey:@"intervalStep"];
    self.imageNum = [userDefaults integerForKey:@"imageNum"];
}

//NSUserDefaults保存
- (void)saveUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.totalStep forKey:@"totalStep"];
    [userDefaults setInteger:self.intervalStep forKey:@"intervalStep"];
    [userDefaults setInteger:self.imageNum forKey:@"imageNum"];
    
    [userDefaults synchronize];
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
