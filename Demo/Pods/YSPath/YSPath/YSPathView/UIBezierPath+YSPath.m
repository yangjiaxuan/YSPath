//
//  UIBezierPath+YSPath.m
//  YSPathView
//
//  Created by yangsen on 2018/5/2.
//  Copyright © 2018年 yangsen. All rights reserved.
//

#import "UIBezierPath+YSPath.h"

static double space = 0.5;

@implementation UIBezierPath (YSPath)

+ (UIBezierPath *)ys_pathWithMinX:(double)minX maxX:(double)maxX function:(double(^)(double x))func{
    UIBezierPath *path = [UIBezierPath bezierPath];
    @autoreleasepool{
        double point_x = minX;
        double point_y = func(point_x);
        [path moveToPoint:CGPointMake(point_x, point_y)];
        point_x += space;
        while (point_x <= maxX) {
            point_y = func(point_x);
            [path addLineToPoint:CGPointMake(point_x, point_y)];
            point_x += space;
        }
    }
    return path;
}

+ (UIBezierPath *)ys_pathWithMinY:(double)minY maxY:(double)maxY function:(double (^)(double))func{
    UIBezierPath *path = [UIBezierPath bezierPath];
    @autoreleasepool{
        double point_y = minY;
        double point_x = func(point_y);
        [path moveToPoint:CGPointMake(point_x, point_y)];
        point_x += space;
        while (point_y <= maxY) {
            point_x = func(point_y);
            [path addLineToPoint:CGPointMake(point_x, point_y)];
            point_y += space;
        }
    }
    return path;
}

@end
