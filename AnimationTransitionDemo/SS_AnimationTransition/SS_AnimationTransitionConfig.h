//
//  AnimationTransitionConfig.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#ifndef SS_AnimationTransitionConfig_h
#define SS_AnimationTransitionConfig_h

//转场动画的时间
static CGFloat SS_AnimationTransitionDuration = 0.5;
//屏幕边缘侧滑手势的移动比例,超出则触发转场
static CGFloat SS_ScreenEdgePanMoveScale = 0.4;
//屏幕边缘侧滑手势的移动速度,超过则触发转场
static CGFloat SS_ScreenEdgePanMoveVelocity = 1000.0;
//页面整体滑动手势的移动比例,超过则触发转场
static CGFloat SS_PanGestureMoveScale = 0.4;
//页面整体滑动手势的移动速度,超过则触发转场
static CGFloat SS_PanGestureMoveVelocity = 1000.0;

typedef NS_ENUM(NSInteger,KSS_AnimationTransitionType){
    KAnimationTransitionTypeNone = 1,       //不自定义动画,使用系统的              -不需要实现SS_AnimationTransitionTargetView
    KAnimationTransitionTypeSmooth,         //平滑的转场,支持Push和Present        -不需要实现SS_AnimationTransitionTargetView
    KAnimationTransitionTypeMagicMove,      //神奇移动转场,仅支持Push              -fromVC和toVC都必须实现SS_AnimationTransitionTargetView
    KAnimationTransitionTypeTikTokComment,  //抖音的评论,仅支持Present            -不需要实现SS_AnimationTransitionTargetView
    KAnimationTransitionTypeMask            //Mask转场,仅支持Push                -fromVC实现SS_AnimationTransitionTargetView,且必须返回UIImageView
};

#endif /* SS_AnimationTransitionConfig_h */
