//
//  AnimationInteractiveTransition.m
//  AnimationTransitionDemo
//
//  Created by 宋澎 on 2018/7/13.
//  Copyright © 2018年 宋澎. All rights reserved.
//

#import "SS_AnimationInteractiveTransition.h"
#import "SS_AnimationTransitionConfig.h"
#import "SS_AnimationMagicMoveEffect.h"
#import "SS_AnimationSmoothEffect.h"
#import "SS_AnimationTikTokEffect.h"
#import "SS_AnimationMaskEffect.h"

@interface SS_AnimationInteractiveTransition () <UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL isBack;               //是否是Pop或者Dismiss
@property (nonatomic,assign) BOOL isInteractive;        //是否手势过渡

@end

@implementation SS_AnimationInteractiveTransition{
    id <UIViewControllerAnimatedTransitioning> _animtedTransitioning;
}

+ (instancetype)shareInteractiveTransition{
    
    static SS_AnimationInteractiveTransition * _shareInteractiveTransition = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInteractiveTransition = [SS_AnimationInteractiveTransition new];
    });
    return _shareInteractiveTransition;
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    //仅在Pop和Dismiss的时候启用手势交互,一般情况下Push和Present的时候不需要手势交互
    return self.isInteractive ? self.isBack ? self : nil : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if(operation == UINavigationControllerOperationPush){
        self.isBack = NO;
    }else if(operation == UINavigationControllerOperationPop){
        self.isBack = YES;
    }
    [self handleAnimatedTransitioning];
    return _animtedTransitioning;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.isBack = NO;
    [self handleAnimatedTransitioning];
    return _animtedTransitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.isBack = YES;
    [self handleAnimatedTransitioning];
    return _animtedTransitioning;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.isInteractive ? self.isBack ? self : nil : nil;//仅在Pop和Dismiss的时候启用手势交互,一般情况下Push和Present的时候不需要手势交互
}

#pragma mark - return UIViewControllerInteractiveTransitioning

- (void)handleAnimatedTransitioning{
    if (self.type == KAnimationTransitionTypeNone){
        _animtedTransitioning = nil;
    }else if (self.type == KAnimationTransitionTypeSmooth) {
        _animtedTransitioning = [[SS_AnimationSmoothEffect alloc] initWithIsBack:self.isBack];
    }else if(self.type == KAnimationTransitionTypeMagicMove){
        _animtedTransitioning = [[SS_AnimationMagicMoveEffect alloc] initWithIsBack:self.isBack];
    }else if(self.type == KAnimationTransitionTypeTikTokComment){
        _animtedTransitioning = [[SS_AnimationTikTokEffect alloc] initWithIsBack:self.isBack];
    }else if(self.type == KAnimationTransitionTypeMask){
        _animtedTransitioning = [[SS_AnimationMaskEffect alloc] initWithIsBack:self.isBack];
    }
}

#pragma mark - setter

- (void)setIsOpenScreenEdgePanGesture:(BOOL)isOpenScreenEdgePanGesture{
    _isOpenScreenEdgePanGesture = isOpenScreenEdgePanGesture;
    if (isOpenScreenEdgePanGesture){
        UIScreenEdgePanGestureRecognizer * edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanGesture:)];
        edgePanGesture.edges = UIRectEdgeLeft;
        edgePanGesture.delegate = self;
        [self.targetView addGestureRecognizer:edgePanGesture];
    }
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePanGesture{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat rate = [edgePanGesture translationInView:keyWindow].x / [UIScreen mainScreen].bounds.size.width;
    CGFloat velocity = [edgePanGesture velocityInView:keyWindow].x;
    [self handleGesture:edgePanGesture rate:rate velocity:velocity];
}

- (void)setDirectionStyle:(PanDirectionStyle)directionStyle{
    _directionStyle = directionStyle;
    if (_directionStyle != DirectionStyleNone) {
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self.targetView addGestureRecognizer:panGesture];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture{
    if(!self.isOpenPanGesture){
        return;
    }
    PanDirectionStyle currentDirction = DirectionStyleNone;
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    CGFloat translationX = [panGesture translationInView:keyWindow].x;
    CGFloat translationY = [panGesture translationInView:keyWindow].y;
    
    CGFloat moveRangeWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat moveRangeHeight = UIScreen.mainScreen.bounds.size.height;
    
    if (self.type == KAnimationTransitionTypeTikTokComment) {
        moveRangeHeight = moveRangeHeight*2/3;
    }
    
    CGFloat rate = [panGesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / moveRangeWidth;
    CGFloat velocity = [panGesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    
    if (fabs(translationX) > fabs(translationY)) {
        if(translationX > 0){
            //右滑
            currentDirction = DirectionStyleRight;
        }else if(translationX < 0){
            //左滑
            currentDirction = DirectionStyleLeft;
        }
    }else{
        rate = fabs([panGesture translationInView:keyWindow].y / moveRangeHeight);
        velocity = fabs([panGesture velocityInView:keyWindow].y);
        if(translationY > 0){
            //下滑
            currentDirction = DirectionStyleDown;
        }else if(translationY < 0){
            //上滑
            currentDirction = DirectionStyleUp;
        }
    }
    if(currentDirction == self.directionStyle){
        [self handleGesture:panGesture rate:MIN(1.0, rate) velocity:velocity];
    }
}

- (void)handleGesture:(UIGestureRecognizer *)gesture rate:(CGFloat)rate velocity:(CGFloat)velocity{
//    NSLog(@"state = %ld \n",(long)gesture.state);
    
    switch (gesture.state){
        case UIGestureRecognizerStateBegan:{
            self.isInteractive = YES;
            if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.currentViewController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            self.isInteractive = NO;
            [self updateInteractiveTransition:rate];
            break;
        }
        default:{
            self.isInteractive = NO;
            if (rate >= SS_ScreenEdgePanMoveScale)
                [self finishInteractiveTransition];
            else
                if (velocity > SS_ScreenEdgePanMoveVelocity)
                    [self finishInteractiveTransition];
                else
                    [self cancelInteractiveTransition];
            break;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self.targetView];
    if (point.x < 100) {
        return YES;
    }else{
        return NO;
    }
}

@end
