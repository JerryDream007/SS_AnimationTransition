//
//  CommonMagicMoveDetailViewController.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "CommonMagicMoveDetailViewController.h"
#import "CommonSmoothViewController.h"
#import "SS_AnimationTransition.h"

@interface CommonMagicMoveDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;

@end

@implementation CommonMagicMoveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片详情";
    self.topImageView.image = [UIImage imageNamed:_currentImageName];
    self.centerLabel.text = _currentImageName;
}

- (IBAction)clickNextButton:(id)sender {
    CommonSmoothViewController * smoothVC = [[CommonSmoothViewController alloc] init];
    [self.navigationController ss_pushViewController:smoothVC type:KAnimationTransitionTypeSmooth];
}

- (void)dealloc{
    
}

#pragma mark - targetView

- (UIView *)SS_AnimationTransitionTargetView{
    return self.topImageView;
}

@end
