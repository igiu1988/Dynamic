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
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
    
    UIDynamicItemBehavior *itemBehaviour;
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
    lastPoint = [[touches anyObject] locationInView:self];
    
    
    
    if (!animator) {
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        itemBehaviour = [[UIDynamicItemBehavior alloc] init];
        itemBehaviour.elasticity = 0.8;
        itemBehaviour.resistance = 0.2;
        itemBehaviour.friction = 0.1;
        itemBehaviour.angularResistance = 0.1;
        itemBehaviour.density = 10000;
        [animator addBehavior:itemBehaviour];
        
    
    }
    if (!gravity) {
        gravity = [[UIGravityBehavior alloc] init];
        
    }
    if (!collision) { 
        collision = [[UICollisionBehavior alloc] init];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        collision.collisionMode = UICollisionBehaviorModeEverything;
    }
//    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    
    
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

#pragma mark - Ball View LifeCycle
- (void)generateBallWithPosition:(CGPoint )p
{
    CGRect rect = CGRectMake(p.x - BALL_RADIUS, p.y - BALL_RADIUS, 2 * BALL_RADIUS, 2 * BALL_RADIUS);
    WYBallView *ball = [[WYBallView alloc] initWithFrame:rect];
    ball.shouldUpdate = ^(WYBallView *ballView){
        [animator updateItemUsingCurrentState:ballView];
    };
    
    [self addSubview:ball];
//    [gravity addItem:ball];
    [collision addItem:ball];
    [itemBehaviour addItem:ball];
    
}

- (void)removeBalls
{
    for (id<UIDynamicItem> item in gravity.items) {
        [gravity removeItem:item];
    }
    for (id<UIDynamicItem> item in collision.items) {
        [collision removeItem:item];
    }
    [animator removeAllBehaviors];
    gravity = nil;
    [collision removeAllBoundaries];
    collision = nil;
    animator = nil;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[WYBallView class]]) {
            [view removeFromSuperview];
            
        }
    }
}


@end
