//
//  UIView+YSPath.h
//  YSPathView
//
//  Created by yangsen on 2018/5/2.
//  Copyright © 2018年 yangsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YSPath)

@property(strong, nonatomic)CAShapeLayer *pathLayer;

- (void)ys_setBezierPath:(UIBezierPath *)bezierPath;

@end
