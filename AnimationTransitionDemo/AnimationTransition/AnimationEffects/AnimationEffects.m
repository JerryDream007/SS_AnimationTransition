//
//  AnimationEffects.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/16.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "AnimationEffects.h"

@implementation AnimationEffects

- (instancetype)initWithIsBack:(BOOL)isBack{
    
    if (self = [super init]) {
        self.isBack = isBack;
    }
    return self;
}

@end
