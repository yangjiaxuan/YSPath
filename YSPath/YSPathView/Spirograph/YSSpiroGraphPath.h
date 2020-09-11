//
//  SpiroGraphPath.h
//  YSPathView
//
//  Created by yangsen on 2019/6/17.
//  Copyright © 2019 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSSpiroGraphPath : UIBezierPath

+ (YSSpiroGraphPath *)pathWithLargeCircleRadius:(int)largeCircleRadius
                              smallCircleRadius:(int)smallCircleRadius
                                          angle:(CGFloat)angle
                                      lineWidth:(CGFloat)lineWidth
                               smallCircleSpace:(int)smallCircleSpace;

- (UIBezierPath *)getLargeCirclePath;

- (UIBezierPath *)getSmallCirclePath;

- (CGPoint)getSmallCircleCenter;

- (void)addAngle:(CGFloat)angle;

- (CGFloat)currentAngle;

- (BOOL)isCompleted;

@end

NS_ASSUME_NONNULL_END
