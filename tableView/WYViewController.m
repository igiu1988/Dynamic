//
//  WYViewController.m
//  tableView
//
//  Created by wangyang on 13-11-7.
//  Copyright (c) 2013年 wangyang. All rights reserved.
//

#import "WYViewController.h"
//
//#import <SDWebImageManager.h>
#import "NSFileManager+MostUsePath.h"
#import "WYGravityBallFunView.h"

#define IMAGE_URL_PATTERN       @"http://bizhi.zhuoku.com/wall/200701/0125/dongwu/dongwu%02d.jpg"
@interface WYViewController ()
{
    
    __weak IBOutlet WYGravityBallFunView *funView;
}
@end

@implementation WYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)memoryReleasa:(id)sender {
    [funView removeBalls];
}




//- (IBAction)dispatch:(id)sender {
//    // 01 ~ 20
//    // http://bizhi.zhuoku.com/wall/200701/0125/dongwu/dongwu20.jpg
//    
//    NSString *saveDir = [NSFileManager directoryPath:@"images"];
//    
//    dispatch_group_t group = dispatch_group_create();
//    for (int i = 1; i<20; i++) {
//        dispatch_group_enter(group);
//        NSString *url = [NSString stringWithFormat:IMAGE_URL_PATTERN, i];
//        
////        [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:url] options:SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
////            NSLog(@"%02d下载完了", i);
////            dispatch_group_leave(group);
////        }];
//        
//        
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority | SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//            NSLog(@"%02d下载完了", i);
//            [data writeToFile:[saveDir stringByAppendingPathComponent:url.lastPathComponent] atomically:YES];
//            
//            // 标识一个这个操作结束了
//            dispatch_group_leave(group);
//        }];
//    }
//    
//    
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"dispatch_group_async");
//    });
//    
//    
//    // 这句话是等待这个group完成，这样会阻断主线程的
////    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    
//
//    // 这句话是在这个group完成时，异步调用一个block
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"下载完成");
//    });
//    
//    // 下载图片时干点别个
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"正在下载" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    [alert show];
//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [alert dismissWithClickedButtonIndex:0 animated:YES];
//    });
//    
//    
//    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        NSLog(@"%zu", index);
//    });
//}



@end
