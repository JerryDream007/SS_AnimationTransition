//
//  CommonMaskViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/19.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonMaskViewController.h"
#import "CommonMaskDetailViewController.h"
#import "SS_AnimationTransition.h"

@interface CommonMaskViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *targetImageView;
@property (weak, nonatomic) IBOutlet UIButton *otherTargetButton;

@end

@implementation CommonMaskViewController{
    BOOL _isClickOtherTargetButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击底部的"点击跳转"按钮
- (IBAction)clickNextButton:(id)sender {
    _isClickOtherTargetButton = NO;
    CommonMaskDetailViewController * detailVC = [[CommonMaskDetailViewController alloc] init];
    [self.navigationController ss_pushViewController:detailVC type:KAnimationTransitionTypeMask];
}

//点击顶部的"发帖"按钮
- (IBAction)clickOtherTargetButton:(id)sender {
    _isClickOtherTargetButton = YES;
    CommonMaskDetailViewController * detailVC = [[CommonMaskDetailViewController alloc] init];
    [self.navigationController ss_pushViewController:detailVC type:KAnimationTransitionTypeMask];
}

- (UIView *)SS_AnimationTransitionTargetView{
    if (_isClickOtherTargetButton) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = self.otherTargetButton.imageView.image;
        imageView.frame = CGRectMake(self.otherTargetButton.frame.origin.x, self.otherTargetButton.frame.origin.y, self.otherTargetButton.frame.size.width, self.otherTargetButton.frame.size.height);
        return imageView;
    }else{
        return self.targetImageView;
    }
}

@end
