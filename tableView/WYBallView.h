//
//  WYBallView.h
//  tableView
//
//  Created by wangyang on 13-11-8.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYBallView : UIView
@property (assign) void (^shouldUpdate) (WYBallView *ball);
@end
