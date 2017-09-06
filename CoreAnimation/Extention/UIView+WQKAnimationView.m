//
//  UIView+WQKAnimationView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "UIView+WQKAnimationView.h"

@implementation UIView (WQKAnimationView)

- (CAAnimation *)springAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration;
{
//    mass : damping : stiffness
//    scale = 1.4
//    30. : 2 : 5000 执行两次缩放
//    13. : 2 : 500 执行一次缩放
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform"];
    springAnimation.mass = 13.; //该系数越小，动画弹性速度越快，
    springAnimation.damping = 2; //该系数越大，动画执行的时间越短
    springAnimation.stiffness = 500;//该系数越大，动画的执行越快次数越多
    [springAnimation setDelegate:self];
//    springAnimation.repeatCount = MAXFLOAT;
    springAnimation.byValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    springAnimation.duration = duration;
    [self.layer addAnimation:springAnimation forKey:@"animationSpring"];
    return springAnimation;
}

- (CAAnimation *)keyFrameAnimationWith:(CGPathRef)path duration:(CGFloat)duration
{
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:self.center];
    [linePath addCurveToPoint:CGPointMake(245, 545) controlPoint1:CGPointMake(450, 100) controlPoint2:CGPointMake(130, 430)];
    path = path == nil ? linePath.CGPath : path;
    keyFrameAnimation.path = path;
    keyFrameAnimation.duration = duration;
    [self.layer addAnimation:keyFrameAnimation forKey:@"animationKeyFrame"];
    return keyFrameAnimation;
}

- (CAAnimation *)flipAnimationView
{
    CASpringAnimation *springAnimation1 = [CASpringAnimation animationWithKeyPath:@"transform"];
    springAnimation1.mass = 18.; //该系数越小，动画弹性速度越快，
    springAnimation1.damping = 2.2; //该系数越大，动画执行的时间越短
    springAnimation1.stiffness = 50;//该系数越大，动画的执行越快次数越多
    [springAnimation1 setDelegate:self];
    springAnimation1.cumulative = YES;
    springAnimation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 1, 0)];
    springAnimation1.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
    springAnimation1.duration = 1;
    [self.layer addAnimation:springAnimation1 forKey:@"animationSpringTranslaSecond"];

    return springAnimation1;
 
}

//很鸡肋基本没有什么用处
//- (CAAnimation *)transitionAnimation
//{
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromTop;
//    [self.layer addAnimation:transition forKey:@"transitionAnimation"];
//    return transition;
//}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

@end
