//
//  AnimationSmooth.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/16.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "SS_AnimationSmoothEffect.h"

@implementation SS_AnimationSmoothEffect

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return SS_AnimationTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.isBack) {
        [self transitionAnimationWithBack:transitionContext];
    }else{
        [self transitionAnimationWithForward:transitionContext];
    }
}

- (void)transitionAnimationWithForward:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [[transitionContext containerView] addSubview:fromView];
    
    [[transitionContext containerView] addSubview:toView];

    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    
    toView.frame = CGRectMake(keyWindow.frame.size.width, 0, keyWindow.frame.size.width, keyWindow.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.frame = CGRectMake(0, 0, keyWindow.frame.size.width, keyWindow.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext containerView].backgroundColor = containerViewColor;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)transitionAnimationWithBack:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [[transitionContext containerView] addSubview:fromView];
    
    [[transitionContext containerView] addSubview:toView];
    
    UIView *fromSnapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    
    [[transitionContext containerView] addSubview:fromSnapShotView];
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    
    fromSnapShotView.frame = CGRectMake(0, 0, keyWindow.frame.size.width, keyWindow.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromSnapShotView.frame = CGRectMake(keyWindow.frame.size.width, 0, keyWindow.frame.size.width, keyWindow.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext containerView].backgroundColor = containerViewColor;
        [fromSnapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
