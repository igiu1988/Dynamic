//
//  WYViewController.m
//  tableView
//
//  Created by wangyang on 13-11-7.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "WYViewController.h"

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dispatch:(id)sender {
    // 01 ~ 20
    // http://bizhi.zhuoku.com/wall/200701/0125/dongwu/dongwu20.jpg
    
    dispatch_group_t group = dispatch_group_create();
    for (int i = 1; i<20; i++) {
        
        dispatch_group_enter(group);
        
    }
    
    // 这句话是等待这个group完成
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    // 这句话是在这个group完成时，异步调用一个block
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UpdateUI();
    });
}



@end
