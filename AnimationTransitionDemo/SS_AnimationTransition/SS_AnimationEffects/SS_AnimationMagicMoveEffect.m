//
//  AnimationMagicMove.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "SS_AnimationMagicMoveEffect.h"

@implementation SS_AnimationMagicMoveEffect

- (instancetype)initWithIsBack:(BOOL)isBack{
    if (self = [super init]) {
        self.isBack = isBack;
    }
    return self;
}

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

//Push或者Present时
- (void)transitionAnimationWithForward:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *fromTargetView = [fromVC SS_AnimationTransitionTargetView];
    UIView *toTargetView = [toVC SS_AnimationTransitionTargetView];
    
    if (!fromTargetView || !toTargetView) {
        [[transitionContext containerView] addSubview:toView];
        [[transitionContext containerView] addSubview:fromView];
        [transitionContext completeTransition:YES];
        return;
    }
    
    [[transitionContext containerView] addSubview:toView];
    toView.alpha = 0.2;
    UIView *fromSnapShotView = [fromTargetView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:fromSnapShotView];
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint fromTargetPoint = [fromTargetView.superview convertPoint:fromTargetView.frame.origin toView:keyWindow];
    CGPoint toTargetPoint = [toTargetView.superview convertPoint:toTargetView.frame.origin toView:keyWindow];
    
    fromSnapShotView.frame = CGRectMake(fromTargetPoint.x, fromTargetPoint.y, fromTargetView.frame.size.width, fromTargetView.frame.size.height);
    toTargetView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromSnapShotView.frame = CGRectMake(toTargetPoint.x, toTargetPoint.y, toTargetView.frame.size.width, toTargetView.frame.size.height);
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        toTargetView.hidden = NO;
        [transitionContext containerView].backgroundColor = containerViewColor;
        [fromSnapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

//Pop或者Dismiss时
- (void)transitionAnimationWithBack:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self transitionAnimationWithForward:transitionContext];
}

@end
