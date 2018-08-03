//
//  CommonSmoothViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/16.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonSmoothViewController.h"
#import "SS_AnimationTransition.h"

@interface CommonSmoothViewController ()

@end

@implementation CommonSmoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"平滑移动效果";
}

#pragma mark - targetView

- (UIView *)SS_AnimationTransitionTargetView{
    return [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
