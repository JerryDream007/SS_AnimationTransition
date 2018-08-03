//
//  AnimationMask.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/19.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "SS_AnimationMaskEffect.h"

@interface SS_AnimationMaskEffect () <CAAnimationDelegate>

@property (nonatomic,weak) UIView * forwardToView;
@property (nonatomic,weak) id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation SS_AnimationMaskEffect

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return SS_AnimationTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    if (self.isBack) {
        [self transitionAnimationWithBack:transitionContext];
    }else{
        [self transitionAnimationWithForward:transitionContext];
    }
}

- (void)transitionAnimationWithForward:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [transitionContext containerView].backgroundColor = toView.backgroundColor;
    UIView *fromTargetView = [fromVC SS_AnimationTransitionTargetView];
    if (!fromTargetView || ![fromTargetView isKindOfClass:[UIView class]]) {
        [[transitionContext containerView] addSubview:fromView];
        [[transitionContext containerView] addSubview:toView];
        [transitionContext completeTransition:YES];
        return;
    }
    
    [[transitionContext containerView] addSubview:fromView];
    [[transitionContext containerView] addSubview:toView];
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    if ([fromTargetView isKindOfClass:[UIImageView class]]) {
        UIImageView * fromTargetImageView = fromTargetView;
        shapeLayer.contents = (__bridge id)fromTargetImageView.image.CGImage;
    }else{
        NSLog(@"请在AnimationTransitionTargetView方法中,返回UIImageView类型的视图");
    }
    
    shapeLayer.bounds = fromTargetView.bounds;
    shapeLayer.position = fromTargetView.center;
    toView.layer.mask = shapeLayer;
    self.forwardToView = toView;
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyFrameAnimation.duration = SS_AnimationTransitionDuration;
    NSValue * startValue = [NSValue valueWithCGRect:CGRectMake(0, 0, fromTargetView.frame.size.width, fromTargetView.frame.size.height)];
    NSValue * finialValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 2000, 2000)];
    keyFrameAnimation.values = @[startValue,finialValue];
    keyFrameAnimation.keyTimes = @[@0,@1];
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.delegate = self;
    [shapeLayer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:YES];
    self.forwardToView.layer.mask = nil;
}

- (void)transitionAnimationWithBack:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *toTargetView = [toVC SS_AnimationTransitionTargetView];
    if (!toTargetView || ![toTargetView isKindOfClass:[UIView class]]) {
        [[transitionContext containerView] addSubview:fromView];
        [[transitionContext containerView] addSubview:toView];
        [transitionContext completeTransition:YES];
        return;
    }
    [[transitionContext containerView] addSubview:toView];
    [[transitionContext containerView] addSubview:fromView];
    self.forwardToView = fromView;
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    if ([toTargetView isKindOfClass:[UIImageView class]]) {
        UIImageView * toTargetImageView = toTargetView;
        shapeLayer.contents = (__bridge id)toTargetImageView.image.CGImage;
    }else{
        NSLog(@"请在AnimationTransitionTargetView方法中,返回UIImageView类型的视图");
    }
    
    shapeLayer.bounds = toTargetView.bounds;
    shapeLayer.position = toTargetView.center;
    fromView.layer.mask = shapeLayer;
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyFrameAnimation.duration = SS_AnimationTransitionDuration;
    NSValue * startValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 2000, 2000)];
    NSValue * finialValue = [NSValue valueWithCGRect:CGRectMake(0, 0, toTargetView.frame.size.width, toTargetView.frame.size.height)];
    keyFrameAnimation.values = @[startValue,finialValue];
    keyFrameAnimation.delegate = self;
    [shapeLayer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation2"];
}

@end
