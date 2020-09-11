//
//  ViewController.m
//  YSPathView
//
//  Created by 杨森 on 2018/5/2.
//  Copyright © 2018年 杨森. All rights reserved.
//

#import "ViewController.h"
#import <YSPath/YSPath.h>


CGFloat kSize(CGFloat size){
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    return screenW / 375 * size;
}

@interface ViewController ()

@property(assign, nonatomic)BOOL isShowLargeCircle;

@property(assign, nonatomic)BOOL isShowSmallCircle;

@property(assign, nonatomic)CGFloat largeCircleRadius;

@property(assign, nonatomic)CGFloat smallCircleRadius;

@property(assign, nonatomic)CGFloat smallCircleSpace;

@property(strong, nonatomic, nullable)YSSpiroGraphPath *spiroGraphPath;

@property(strong, nonatomic, nullable)UITextField *largeCircleRadiusTF;

@property(strong, nonatomic, nullable)UITextField *smallCircleRadiusTF;

@property(strong, nonatomic, nullable)UITextField *smallCircleSpaceTF;

@property(strong, nonatomic, nullable)UISwitch *showLargeCircleSwitch;

@property(strong, nonatomic, nullable)UISwitch *showSmallCircleSwitch;

@property(strong, nonatomic, nullable)UIButton *startOrStopBtn;

@property(strong, nonatomic, nullable)UIButton *resetBtn;

@end

@implementation ViewController{
    double x;
    CADisplayLink *link;
    CAShapeLayer  *shapeLayer;
    CAShapeLayer  *largeCircleLayer;
    CAShapeLayer  *smallCircleLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isShowLargeCircle = true;
    _isShowSmallCircle = true;
    _largeCircleRadius = 153;
    _smallCircleRadius = 67;
    _smallCircleSpace = 60;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CAGradientLayer *gL = [CAGradientLayer layer];
    gL.frame     = self.view.bounds;
    gL.locations = @[@0.2, @0.5, @0.8];
    gL.colors    = @[(id)[UIColor redColor].CGColor,
                     (id)[UIColor yellowColor].CGColor,
                     (id)[UIColor greenColor].CGColor];
    gL.startPoint = CGPointMake(0, 0);
    gL.endPoint   = CGPointMake(1, 0);
    [self.view.layer addSublayer:gL];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(kSize(33), kSize(50), kSize(308), kSize(355));
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor   = [UIColor clearColor].CGColor;
    gL.mask = shapeLayer;
    
    largeCircleLayer = [CAShapeLayer layer];
    largeCircleLayer.frame = CGRectMake(kSize(33), kSize(50), kSize(308), kSize(355));
    largeCircleLayer.strokeColor = [UIColor purpleColor].CGColor;
    largeCircleLayer.fillColor   = [UIColor clearColor].CGColor;
    largeCircleLayer.lineWidth = 2;
    [self.view.layer addSublayer:largeCircleLayer];
    
    smallCircleLayer = [CAShapeLayer layer];
    smallCircleLayer.frame = CGRectMake(kSize(33), kSize(50), kSize(308), kSize(355));
    smallCircleLayer.strokeColor = [UIColor blueColor].CGColor;
    smallCircleLayer.fillColor   = [UIColor clearColor].CGColor;
    smallCircleLayer.lineWidth = 2;
    [self.view.layer addSublayer:smallCircleLayer];
    
    CGFloat space = kSize(15);
    _largeCircleRadiusTF = [[UITextField alloc] initWithFrame:CGRectMake(kSize(10), kSize(408), kSize(355), kSize(30))];
    _largeCircleRadiusTF.backgroundColor = [UIColor purpleColor];
    _largeCircleRadiusTF.textColor = [UIColor whiteColor];
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSize(150), kSize(30))];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.textColor = [UIColor redColor];
    leftView.textAlignment = NSTextAlignmentCenter;
    leftView.text = @"大圆半径：";
    _largeCircleRadiusTF.leftView = leftView;
    _largeCircleRadiusTF.leftViewMode = UITextFieldViewModeAlways;
    _largeCircleRadiusTF.layer.cornerRadius = kSize(4);
    _largeCircleRadiusTF.layer.masksToBounds = true;
    _largeCircleRadiusTF.text = [NSString stringWithFormat:@"%.0f", _largeCircleRadius];
    [self.view addSubview:_largeCircleRadiusTF];
    
    _smallCircleRadiusTF = [[UITextField alloc] initWithFrame:CGRectMake(kSize(10), CGRectGetMaxY(_largeCircleRadiusTF.frame) + space, kSize(355), kSize(30))];
    _smallCircleRadiusTF.backgroundColor = [UIColor purpleColor];
    _smallCircleRadiusTF.textColor = [UIColor whiteColor];
    leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSize(150), kSize(30))];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.textColor = [UIColor redColor];
    leftView.textAlignment = NSTextAlignmentCenter;
    leftView.text = @"小圆半径：";
    _smallCircleRadiusTF.leftView = leftView;
    _smallCircleRadiusTF.leftViewMode = UITextFieldViewModeAlways;
    _smallCircleRadiusTF.layer.cornerRadius = kSize(4);
    _smallCircleRadiusTF.layer.masksToBounds = true;
    _smallCircleRadiusTF.text = [NSString stringWithFormat:@"%.0f", _smallCircleRadius];
    [self.view addSubview:_smallCircleRadiusTF];
    
    _smallCircleSpaceTF = [[UITextField alloc] initWithFrame:CGRectMake(kSize(10), CGRectGetMaxY(_smallCircleRadiusTF.frame) + space, kSize(355), kSize(30))];
    _smallCircleSpaceTF.backgroundColor = [UIColor purpleColor];
    _smallCircleSpaceTF.textColor = [UIColor whiteColor];
    leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSize(150), kSize(30))];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.textColor = [UIColor redColor];
    leftView.textAlignment = NSTextAlignmentCenter;
    leftView.text = @"小圆作用点间距：";
    _smallCircleSpaceTF.leftView = leftView;
    _smallCircleSpaceTF.leftViewMode = UITextFieldViewModeAlways;
    _smallCircleSpaceTF.layer.cornerRadius = kSize(4);
    _smallCircleSpaceTF.layer.masksToBounds = true;
    _smallCircleSpaceTF.text = [NSString stringWithFormat:@"%.0f", _smallCircleSpace];
    [self.view addSubview:_smallCircleSpaceTF];
    
    _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _resetBtn.frame = CGRectMake(kSize(10), CGRectGetMaxY(_smallCircleSpaceTF.frame) + 2*space, kSize(172), kSize(30));
    _resetBtn.backgroundColor = [UIColor purpleColor];
    [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    _resetBtn.layer.cornerRadius = kSize(4);
    _resetBtn.layer.masksToBounds = true;
    [_resetBtn addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetBtn];
    
    _startOrStopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startOrStopBtn.frame = CGRectMake(CGRectGetMaxX(_resetBtn.frame) + kSize(10), _resetBtn.frame.origin.y, kSize(172), kSize(30));
    _startOrStopBtn.backgroundColor = [UIColor purpleColor];
    [_startOrStopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startOrStopBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_startOrStopBtn setTitle:@"暂停" forState:UIControlStateSelected];
    _startOrStopBtn.layer.cornerRadius = kSize(4);
    _startOrStopBtn.layer.masksToBounds = true;
    [_startOrStopBtn addTarget:self action:@selector(startOrStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startOrStopBtn];
    
    _showSmallCircleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kSize(10), CGRectGetMaxY(_startOrStopBtn.frame) + 2*kSize(10), 0, 0)];
    [_showSmallCircleSwitch addTarget:self action:@selector(showSmallCirlce:) forControlEvents:UIControlEventValueChanged];
    _showSmallCircleSwitch.on = true;
    [self.view addSubview:_showSmallCircleSwitch];
    
    _showLargeCircleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(kSize(300), CGRectGetMaxY(_startOrStopBtn.frame) + 2*kSize(10), 0, 0)];
    [_showLargeCircleSwitch addTarget:self action:@selector(showLargeCirlce:) forControlEvents:UIControlEventValueChanged];
    _showLargeCircleSwitch.on = true;
    [self.view addSubview:_showLargeCircleSwitch];
    
    [self createPath];
}

- (void)createPath{
    _spiroGraphPath = [YSSpiroGraphPath pathWithLargeCircleRadius:kSize(_largeCircleRadius) smallCircleRadius:kSize(_smallCircleRadius) angle:0 lineWidth:1 smallCircleSpace:kSize(_smallCircleSpace)];
}

- (void)startOrStop:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
    [self distoryLink];
    if (sender.isSelected == true) {
        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawsSpiroGraph)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)reset:(UIButton *)sender{
    [self distoryLink];
    
    _startOrStopBtn.selected = true;
    [self startOrStop:_startOrStopBtn];
    
    _largeCircleRadius = [_largeCircleRadiusTF.text integerValue];
    _smallCircleRadius = [_smallCircleRadiusTF.text integerValue];
    _smallCircleSpace = [_smallCircleSpaceTF.text integerValue];
    
    [self createPath];
}

- (void)distoryLink{
    if (link) {
        [link setPaused:YES];
        [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        link = nil;
    }
}

- (void)drawsSpiroGraph{
    
    [_spiroGraphPath addAngle:0.01];

    largeCircleLayer.path = _spiroGraphPath.getLargeCirclePath.CGPath;

    smallCircleLayer.path = _spiroGraphPath.getSmallCirclePath.CGPath;

    shapeLayer.path = _spiroGraphPath.CGPath;
    
}

- (void)showSmallCirlce:(UISwitch *)sender{
    self.isShowSmallCircle = sender.isOn;
    smallCircleLayer.hidden = !self.isShowSmallCircle;
}

- (void)showLargeCirlce:(UISwitch *)sender{
    self.isShowLargeCircle = sender.isOn;
    largeCircleLayer.hidden = !self.isShowLargeCircle;
}

@end
