//
//  AnimationInteractiveTransition.h
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_AnimationTransitionConfig.h"

typedef NS_ENUM(NSInteger,PanDirectionStyle){
    DirectionStyleNone = 1,     //不增加滑动手势
    DirectionStyleLeft,         //响应左滑手势
    DirectionStyleRight,        //响应右滑手势
    DirectionStyleUp,           //响应上滑手势
    DirectionStyleDown          //响应下滑手势
};

@interface SS_AnimationInteractiveTransition : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic,weak) UINavigationController * navigationController;   //使用Push转场时使用,其它情况应为nil
@property (nonatomic,weak) UIViewController * currentViewController;        //使用Present转场时使用,其它情况应为nil
@property (nonatomic,weak) UIView * targetView;                 //增加手势的目标视图
@property (nonatomic,assign) BOOL isOpenScreenEdgePanGesture;   //是否开启侧滑返回手势
//利用此参数,可以自定义滑动时机,例如:当contenOffset=0时,在开启滑动手势
@property (nonatomic,assign) BOOL isOpenPanGesture;             //是否开启整体滑动手势
@property (nonatomic,assign) PanDirectionStyle directionStyle;  //是否开启整体滑动手势
@property (nonatomic,assign) KSS_AnimationTransitionType type;     //动画类型

+ (instancetype)shareInteractiveTransition;
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture;

@end
