//
//  UIBezierPath+YSPath.h
//  YSPathView
//
//  Created by yangsen on 2018/5/2.
//  Copyright © 2018年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (YSPath)

+ (UIBezierPath *)ys_pathWithMinX:(double)minX maxX:(double)maxX function:(double(^)(double x))func;

+ (UIBezierPath *)ys_pathWithMinY:(double)minY maxY:(double)maxY function:(double(^)(double y))func;

@end
