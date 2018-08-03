//
//  UINavigationController+AnimationTransition.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_AnimationTransitionConfig.h"

@interface UINavigationController (SS_AnimationTransition)

- (void)ss_pushViewController:(UIViewController *)viewController type:(KSS_AnimationTransitionType)type;

@end
