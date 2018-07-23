//
//  UINavigationController+AnimationTransition.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AnimationTransitionConfig.h"

@interface UINavigationController (AnimationTransition)

- (void)animation_pushViewController:(UIViewController *)viewController type:(KAnimationTransitionType)type;

@end
