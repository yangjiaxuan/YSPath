//
//  UIView+YSPath.m
//  YSPathView
//
//  Created by yangsen on 2018/5/2.
//  Copyright © 2018年 yangsen. All rights reserved.
//

#import "UIView+YSPath.h"
#import <objc/runtime.h>

@implementation UIView (YSPath)
#define kUIView_YSPathKey_pathLayer @"kUIView_YSPathKey_pathLayer"
- (void)setPathLayer:(CAShapeLayer *)pathLayer{
    objc_setAssociatedObject(self, kUIView_YSPathKey_pathLayer, pathLayer, OBJC_ASSOCIATION_RETAIN);
}
- (CAShapeLayer *)pathLayer{
    CAShapeLayer *layer = objc_getAssociatedObject(self, kUIView_YSPathKey_pathLayer);
    if (!layer) {
        layer             = [CAShapeLayer layer];
        layer.fillColor   = [UIColor whiteColor].CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;
        self.pathLayer    = layer;
        [self.layer addSublayer:layer];
    }
    return layer;
}

- (void)ys_setBezierPath:(UIBezierPath *)bezierPath{

    self.pathLayer.path = bezierPath.CGPath;
}

@end
