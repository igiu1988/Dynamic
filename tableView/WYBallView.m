//
//  WYBallView.m
//  tableView
//
//  Created by wangyang on 13-11-8.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "WYBallView.h"
#define BALL_COULOR         [UIColor redColor]
@implementation WYBallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 想要这个view背景透明这句话少不了
        // 在drawRect里的CGContextClearRect(context, rect);也不可少
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
//    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGContextFillRect(context, self.bounds);
    
    CGContextSetLineWidth(context, 0);
    
    CGContextSetFillColorWithColor(context, BALL_COULOR.CGColor);
//    CGContextAddEllipseInRect(context, rect);
    CGContextFillEllipseInRect(context, rect);
    
    
    CGContextStrokePath(context);
}


@end
