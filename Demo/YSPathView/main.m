//
//  main.m
//  YSPathView
//
//  Created by 杨森 on 2018/5/2.
//  Copyright © 2018年 杨森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
//    // 求执行次数（最小公倍数/静圆半径）
//    int m = R, n = r;
//    int tmp;
//    while (n != 0)
//    {
//        tmp = m % n;
//        m = n;
//        n = tmp;
//    }
//    double maxdegree = r / m * 2 * PI;    //
//
//    // 绘图
//    int x, y;
//    for (double degree = 0; degree < maxdegree; degree += 0.01)
//    {
//        x = (int)(dr * cos(degree*(double(R) / r - 1)) + (R - r) * cos(degree));
//        y = (int)(dr * sin(degree*(double(R) / r - 1)) - (R - r) * sin(degree));
//        putpixel(x, y, GREEN);
//    }
//}
