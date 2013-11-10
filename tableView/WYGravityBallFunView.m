//
//  WYGravityBallFunView.m
//  tableView
//
//  Created by wangyang on 13-11-9.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "WYGravityBallFunView.h"
#import "WYBallView.h"

#define BALL_RADIUS         10.0
#define BALL_DISATANCE      30.0

#define BALL_CRAETE_TIME    0.07
@interface WYGravityBallFunView() <UIGestureRecognizerDelegate>
{
    CGPoint lastPoint;
    CGPoint currentPoint;
    
    NSTimer *timer;
    
    UIDynamicAnimator *animator;
    UIGravityBehavior *behavior;
}
@end

@implementation WYGravityBallFunView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewInit];
    }
    return self;
}

- (void)awakeFromNib{
    [self viewInit];
}

- (void)viewInit
{
    
    
//    behavior.gravityDirection = CGVectorMake(1.0, 0);
//    [behavior setAngle:M_PI_4 magnitude:1.0];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    [self addGestureRecognizer:longPress];

}

#pragma mark - Create balls though touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!animator) {
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    if (!behavior) {
        behavior = [[UIGravityBehavior alloc] init];
        
    }
    [animator addBehavior:behavior];
    
    lastPoint = [[touches anyObject] locationInView:self];
    currentPoint = lastPoint;
    [self generateBallWithPosition:lastPoint];
    timer = [NSTimer scheduledTimerWithTimeInterval:BALL_CRAETE_TIME target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    currentPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [timer invalidate];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [timer invalidate];
}

- (void)timerHandler
{
    [self generateBallWithPosition:currentPoint];
}

-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    //下面就是高中的数学，不详细解释了
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}
#pragma mark - Ball View LifeCycle
- (void)generateBallWithPosition:(CGPoint )p
{
    CGRect rect = CGRectMake(p.x - BALL_RADIUS, p.y - BALL_RADIUS, 2 * BALL_RADIUS, 2 * BALL_RADIUS);
    WYBallView *ball = [[WYBallView alloc] initWithFrame:rect];
    [self addSubview:ball];
    [behavior addItem:ball];
}

- (void)removeBalls
{
    for (id<UIDynamicItem> item in behavior.items) {
        [behavior removeItem:item];
        UIView *view = (UIView *)item;
        [view removeFromSuperview];
    }
    [animator removeAllBehaviors];
    behavior = nil;
    animator = nil;
}


@end
