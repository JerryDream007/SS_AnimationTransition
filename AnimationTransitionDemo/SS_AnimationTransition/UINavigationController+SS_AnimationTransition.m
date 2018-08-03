//
//  UINavigationController+AnimationTransition.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "UINavigationController+SS_AnimationTransition.h"
#import "SS_AnimationInteractiveTransition.h"
#import "UIViewController+SS_AnimationTransition.h"

@implementation UINavigationController (SS_AnimationTransition)

- (void)ss_pushViewController:(UIViewController *)viewController type:(KSS_AnimationTransitionType)type{
    if (type == KAnimationTransitionTypeNone) {
        [self none_pushViewController:viewController];
    }else if (type == KAnimationTransitionTypeSmooth) {
        [self smooth_pushViewController:viewController];
    }else if (type == KAnimationTransitionTypeMagicMove){
        [self magicMove_pushViewController:viewController];
    }else if(type == KAnimationTransitionTypeMask){
        [self mask_pushViewController:viewController];
    }else{
        [self none_pushViewController:viewController];
    }
}

- (void)none_pushViewController:(UIViewController *)viewController{
    self.delegate = nil;
    viewController.animationTransitionDelegate = nil;
    [self pushViewController:viewController animated:true];
}

- (void)smooth_pushViewController:(UIViewController *)viewController{
    self.animationTransitionDelegate = [[SS_AnimationInteractiveTransition alloc] init];
    self.animationTransitionDelegate.type = KAnimationTransitionTypeSmooth;
    self.animationTransitionDelegate.targetView = viewController.view;         //增加手势
    self.animationTransitionDelegate.navigationController = self;             //手势控制返回
    self.animationTransitionDelegate.isOpenPanGesture = NO;                   //开启滑动手势
    self.animationTransitionDelegate.directionStyle = DirectionStyleNone;     //设置侧滑方向
    self.animationTransitionDelegate.isOpenScreenEdgePanGesture = YES;        //开启侧滑返回,注意:手势重叠问题
    self.delegate = self.animationTransitionDelegate;
    
    viewController.animationTransitionDelegate = self.animationTransitionDelegate;
    [self pushViewController:viewController animated:YES];
}

- (void)magicMove_pushViewController:(UIViewController *)viewController{
    self.animationTransitionDelegate = [[SS_AnimationInteractiveTransition alloc] init];
    self.animationTransitionDelegate.type = KAnimationTransitionTypeMagicMove;
    self.animationTransitionDelegate.targetView = viewController.view;         //增加手势
    self.animationTransitionDelegate.navigationController = self;             //手势控制返回
    self.animationTransitionDelegate.isOpenPanGesture = YES;                  //开启滑动手势
    self.animationTransitionDelegate.directionStyle = DirectionStyleUp;       //设置侧滑方向
    self.animationTransitionDelegate.isOpenScreenEdgePanGesture = YES;        //开启侧滑返回,注意:手势重叠问题
    self.delegate = self.animationTransitionDelegate;
    
    viewController.animationTransitionDelegate = self.animationTransitionDelegate;
    [self pushViewController:viewController animated:YES];
}

- (void)mask_pushViewController:(UIViewController *)viewController{
    self.animationTransitionDelegate = [[SS_AnimationInteractiveTransition alloc] init];
    self.animationTransitionDelegate.type = KAnimationTransitionTypeMask;
    self.animationTransitionDelegate.targetView = viewController.view;        //增加手势
    self.animationTransitionDelegate.navigationController = self;             //手势控制返回
    self.animationTransitionDelegate.isOpenPanGesture = NO;                  //开启滑动手势
    self.animationTransitionDelegate.directionStyle = DirectionStyleNone;     //设置侧滑方向
    self.animationTransitionDelegate.isOpenScreenEdgePanGesture = YES;        //开启侧滑返回,注意:手势重叠问题
    self.delegate = self.animationTransitionDelegate;
    
    viewController.animationTransitionDelegate = self.animationTransitionDelegate;
    [self pushViewController:viewController animated:YES];
}

@end
