//
//  CommonTikTokCommentViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/16.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonTikTokCommentViewController.h"

#import "CommonTikTokDetailViewController.h"

#import "AnimationTransition.h"

@interface CommonTikTokCommentViewController ()

@end

@implementation CommonTikTokCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"抖音评论效果";
}

- (IBAction)clickCommentButton:(id)sender {
    CommonTikTokDetailViewController * detailVC = [[CommonTikTokDetailViewController alloc] init];
    
    [self animation_presentVC:detailVC type:KAnimationTransitionTypeTikTokComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
