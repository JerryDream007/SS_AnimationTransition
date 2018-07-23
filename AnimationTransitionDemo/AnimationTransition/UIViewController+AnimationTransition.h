//
//  UIViewController+AnimationTransition.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AnimationTransitionConfig.h"

@class AnimationInteractiveTransition;

@interface UIViewController (AnimationTransition)

@property (nonatomic,strong) AnimationInteractiveTransition * animationTransitionDelegate;

//返回转场的目标视图,某些转场中必须实现这个方法
- (UIView *)AnimationTransitionTargetView;

- (void)animation_presentVC:(UIViewController *)viewController type:(KAnimationTransitionType)type;

@end
