//
//  StepManager.h
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/13.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

//加速度情報格納用構造体
typedef struct{
    int x;
    int y;
    int z;
}accPos;

@interface StepManager : NSObject

@property (nonatomic) int intervalStep, imageNum;
@property (nonatomic) BOOL pictureChangeFlag;

- (void)readUserDefaults;
- (void)saveUserDefaults;
- (int)countCheck:(accPos)accPos;
- (int)imageCheck;
- (void)resetInterval;

@end
