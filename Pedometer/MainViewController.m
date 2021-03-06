//
//  ViewController.m
//  Pedometer
//
//  Created by 中澤 剛 on 12/10/12.
//  Copyright (c) 2012年 Go Nakazawa. All rights reserved.
//

#import "MainViewController.h"
#import "InfoViewController.h"
#import "StepManager.h"

@interface MainViewController () <UIAlertViewDelegate>

//@property宣言
@property (nonatomic, retain) UILabel *stepLabel;                   //(View) 歩数表示ラベル
@property (nonatomic, retain) UIImageView *pictureView;             //(View) 画像表示ビュー
@property (nonatomic, retain) CMMotionManager *motionManager;       //(Model) モーションセンサ管理
@property (nonatomic, retain) StepManager *stepManager;             //(Model) 歩数管理

@end

@implementation MainViewController

//@synthesize宣言
//Xcode 4.4.1以降、@propertyさえ宣言されていれば@synthesizeは自動生成される
@synthesize stepLabel = _stepLabel;
@synthesize pictureView = _pictureView;
@synthesize motionManager = _motionManager;
@synthesize stepManager = _stepManager;

- (CMMotionManager *)motionManager
{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.3;       //加速度センサー更新間隔の設定
    }
    return _motionManager;
}

- (StepManager *)stepManager
{
    if (!_stepManager) {
        _stepManager = [[StepManager alloc] init];
        [_stepManager readUserDefaults];
    }
    return _stepManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self positionCheck];
    [self pictureDisplay:[self.stepManager imageNum]];
    [self stepDisplay:[self.stepManager intervalStep]];
    
    //リセットボタン
    UIButton *reset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    reset.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    [reset setTitle:@"clear" forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reset];
    //インフォビューボタン
    UIButton *info = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    info.frame = CGRectMake(40.0, 0.0, 40.0, 40.0);
    [info setTitle:@"info" forState:UIControlStateNormal];
    [info addTarget:self action:@selector(infoViewModal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:info];
	
}

- (void)viewDidUnload
{
    //メモリ解放準備
    [self setStepLabel:nil];
    [self setPictureView:nil];
    [self setMotionManager:nil];
    [self setStepManager:nil];
    
    [super viewDidUnload];
    
}

- (void)dealloc
{
    //メモリ解放
    [self.stepLabel release];
    [self.pictureView release];
    [self.motionManager release];
    [self.stepManager release];
    
    [super dealloc];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //デバイスの画面固定
    //縦の上下のみサポート（横の左右は許容しない）
    return (interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

//加速度センサーの更新確認
- (void)positionCheck
{
    NSOperationQueue *queue = [NSOperationQueue currentQueue];

    if (![self.motionManager isAccelerometerActive]) {
        [self.motionManager startAccelerometerUpdatesToQueue:queue
                                                 withHandler:^(CMAccelerometerData *accData, NSError *error) {
                                                     accPos accPos;
                                                     accPos.x = accData.acceleration.x;
                                                     accPos.y = accData.acceleration.y;
                                                     accPos.z = accData.acceleration.z;
                                                     //歩数表示ラベルの更新
                                                     [self stepDisplay:[self.stepManager countCheck:accPos]];
                                                     //画像表示ビューの更新（更新フラグがtrueのとき）
                                                     if (self.stepManager.pictureChangeFlag) {
                                                         [self pictureDisplay:[self.stepManager imageCheck]];
                                                     }
                                                 }];
    }
}

//画像表示ビューの表示
- (void)pictureDisplay:(int)imageNum
{
    //初回呼び出し時
    if (!self.pictureView) {
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
        [self.view addSubview:self.pictureView];
    }
    
    self.pictureView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", imageNum]];
}
    
//歩数表示ラベルの表示
- (void)stepDisplay:(int)stemNum
{
    //初回呼び出し時
    if (!self.stepLabel) {
        self.stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
        self.stepLabel.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
        self.stepLabel.textColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:0.7];
        self.stepLabel.textAlignment = UITextAlignmentCenter;
        self.stepLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:28];
        [self.view addSubview:self.stepLabel];
    }
    
    self.stepLabel.text = [NSString stringWithFormat:@"%dStep", stemNum];
}
- (void)resetAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"reset number of step?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.stepManager resetInterval];
        [self stepDisplay:[self.stepManager intervalStep]];
    }
}

- (void)infoViewModal
{
    InfoViewController *infoView = [[[InfoViewController alloc] init]autorelease];
    infoView.modalPresentationStyle = UIModalPresentationFullScreen;
    infoView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:infoView animated:YES];
}

@end
