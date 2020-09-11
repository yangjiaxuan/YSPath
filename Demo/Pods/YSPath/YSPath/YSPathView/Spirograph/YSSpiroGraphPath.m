//
//  SpiroGraphPath.m
//  YSPathView
//
//  Created by yangsen on 2019/6/17.
//  Copyright © 2019 yangsen. All rights reserved.
//

#import "YSSpiroGraphPath.h"

@interface YSPoint : NSObject

@property(assign, nonatomic)CGPoint x;
@property(assign, nonatomic)CGPoint y;

@end
@implementation YSPoint
@end

@interface YSSpiroGraphPath()

@property(assign, nonatomic)int largeCircleRadius;

@property(assign, nonatomic)int smallCircleSpace;

@property(assign, nonatomic)int smallCircleRadius;

@property(assign, nonatomic)CGFloat angle;

@property(assign, nonatomic)CGFloat maxAngle;

@property(assign, nonatomic)CGFloat stockLineWidth;

@property(strong, nonatomic, nullable)NSMutableArray *pointArray;

@property(nonatomic)CGPathRef smallCirclePath;

@property(nonatomic)CGPathRef largeCirclePath;

@property(nonatomic)CGMutablePathRef pointPath;

@end
@implementation YSSpiroGraphPath

+ (YSSpiroGraphPath *)pathWithLargeCircleRadius:(int)largeCircleRadius
                              smallCircleRadius:(int)smallCircleRadius
                                          angle:(CGFloat)angle
                                      lineWidth:(CGFloat)lineWidth
                               smallCircleSpace:(int)smallCircleSpace {
    
    YSSpiroGraphPath *path = [YSSpiroGraphPath bezierPath];
    path.largeCircleRadius = largeCircleRadius;
    path.smallCircleRadius = smallCircleRadius;
    path.smallCircleSpace = smallCircleSpace;
    path.angle = angle;
    path.stockLineWidth = lineWidth;
    [path createPath];
    return path;
}

- (instancetype)init{
    if (self = [super init]) {
        self.smallCircleSpace = 0;
        self.stockLineWidth = 1;
        self.angle = 0;
        self.pointArray = [NSMutableArray array];
        self.pointPath = CGPathCreateMutable();
    }
    return self;
}

- (UIBezierPath *)getLargeCirclePath{
    return [UIBezierPath bezierPathWithCGPath: _largeCirclePath];
}

- (UIBezierPath *)getSmallCirclePath{
    return [UIBezierPath bezierPathWithCGPath: _smallCirclePath];
}

- (void)addAngle:(CGFloat)angle{
    self.angle += angle;
    
    // 1. 计算小圆的路径
    [self creatSmallCirclePath];
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 2. 添加小圆的轨迹点坐标
    // 1) 添加轨迹坐标
    CGPoint point = [self getCurrentGrapthPathPoint];
    CGPathAddLineToPoint(self.pointPath, nil, point.x, point.y);
    // 2) 添加轨迹
    CGPathAddPath(path, nil, self.pointPath);
    self.CGPath = path;
    CGPathRelease(path);
}


- (void)createPath{
    
    // 1. 计算大圆的位置
    [self createLargeCirclePath];
    
    CGFloat angle = self.angle;
    self.angle = -0.01;
    while (self.angle < angle) {
        [self addAngle:0.01];
    }
    
    CGPoint point = [self getCurrentGrapthPathPoint];
    CGPathMoveToPoint(self.pointPath, nil, point.x, point.y);
    
    int m = _largeCircleRadius, n = _smallCircleSpace;
    int temp;
    while(n != 0){
        temp = m % n;
        m = n;
        n = temp;
    }
    
    //计算最大极角（根据最小公倍数）
    self.maxAngle = _smallCircleSpace * 2 * M_PI / m;
}

- (void)createLargeCirclePath{
    CGFloat centerX = _largeCircleRadius + _stockLineWidth;
    self.largeCirclePath = CGPathCreateWithRoundedRect(CGRectMake(0, 0, 2*centerX, 2*centerX), centerX, centerX, nil);
}

- (void)creatSmallCirclePath{
    if (self.smallCirclePath != NULL) {
        CGPathRelease(self.smallCirclePath);
    }
    CGPoint smallCirlceCenter = [self getSmallCircleCenter];
    CGFloat smallCirlceX = smallCirlceCenter.x - _smallCircleRadius;
    CGFloat smallCirlceY = smallCirlceCenter.y - _smallCircleRadius;
    CGPathRef path = CGPathCreateWithRoundedRect(CGRectMake(smallCirlceX, smallCirlceY, 2*_smallCircleRadius, 2*_smallCircleRadius), _smallCircleRadius, _smallCircleRadius, nil);
    self.smallCirclePath = path;
}

- (CGPoint)getSmallCircleCenter{
    CGFloat radiusLength = self.largeCircleRadius - self.smallCircleRadius;
    CGFloat smallCirlceCenterX = _largeCircleRadius + _stockLineWidth + radiusLength * cos(_angle);
    CGFloat smallCirlceCenterY = _largeCircleRadius + _stockLineWidth + radiusLength * sin(_angle);
    return CGPointMake(smallCirlceCenterX, smallCirlceCenterY);
}

- (CGPoint)getCurrentGrapthPathPoint{
    
    CGPoint smallCirlceCenter = [self getSmallCircleCenter];
    // 1) 旋转的角度
    CGFloat smallAngle = (_angle * _largeCircleRadius) / _smallCircleRadius;
    // 2) 坐标点
    CGFloat pointX = smallCirlceCenter.x - _smallCircleSpace * cos(smallAngle);
    CGFloat pointY = smallCirlceCenter.y - _smallCircleSpace * sin(smallAngle);
    return CGPointMake(pointX, pointY);
}

- (CGFloat)currentAngle{
    return _angle;
}

- (BOOL)isCompleted{
    return self.angle >= self.maxAngle;
}

@end
