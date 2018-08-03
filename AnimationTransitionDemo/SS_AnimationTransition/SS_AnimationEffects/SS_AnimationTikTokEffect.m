//
//  AnimationTikTok.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/17.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "SS_AnimationTikTokEffect.h"

@implementation SS_AnimationTikTokEffect

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
    
    UIView * fromSnapView = [fromView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:fromSnapView];
    [[transitionContext containerView] addSubview:toView];
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    toView.frame = CGRectMake(0, keyWindow.frame.size.height, keyWindow.frame.size.width, keyWindow.frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, keyWindow.frame.size.height/3, keyWindow.frame.size.width, keyWindow.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext containerView].backgroundColor = containerViewColor;
        [fromSnapView removeFromSuperview];
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

    /*
     Custom 模式：presentation 结束后，presentingView(fromView) 未被主动移出视图结构，在 dismissal 中，注意不要像其他转场中那样将 presentingView(toView) 加入 containerView 中，否则 dismissal 结束后本来可见的 presentingView 将会随着 containerView 一起被移除。如果你在 Custom 模式下没有注意到这点，很容易出现黑屏之类的现象而不知道问题所在。
     */
    UIView * toSnapView = [toView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:toSnapView];
    [[transitionContext containerView] addSubview:fromView];
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    fromView.frame = CGRectMake(0, keyWindow.frame.size.height/3, keyWindow.frame.size.width, keyWindow.frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(0, keyWindow.frame.size.height, keyWindow.frame.size.width, keyWindow.frame.size.height);
    } completion:^(BOOL finished) {
        [toSnapView removeFromSuperview];
        [transitionContext containerView].backgroundColor = containerViewColor;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled]; 
    }];
}

@end
