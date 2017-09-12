//
//  UIView+WQKAnimationView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "UIView+WQKAnimationView.h"
#import <AVFoundation/AVFoundation.h>
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
    return springAnimation;
}

- (CAAnimation *)basicAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    basicAnimation.fromValue = [NSValue valueWithCGRect:self.bounds];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.bounds.size.width * scale, self.bounds.size.width * scale)];
//    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basicAnimation.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :8 :0.7 :10];
    basicAnimation.duration = duration;
    return basicAnimation;
}

//弹簧进入
- (CAAnimation *)springIntoAnimationViewWith:(WQKAnimationDerictionType)directionType
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint
                                    duration:(NSTimeInterval)duration
{
    NSArray *valueArray = nil;
    switch (directionType) {
        case WQKAnimationDerictionTop:
        {
            CGFloat X = startPoint.x;
            CGFloat startY = startPoint.y;
            CGFloat endY = endPoint.y;
            CGFloat space = (endY - startY) / 10.;
            CGFloat backPointY = endY - space;
            CGFloat advancePointY = endY + space;
            valueArray = @[[NSValue valueWithCGPoint:CGPointMake(X, startY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)]];
        }
            break;
        case WQKAnimationDerictionBottom:
        {
            CGFloat X = startPoint.x;
            CGFloat startY = startPoint.y;
            CGFloat endY = endPoint.y;
            CGFloat space = (startY - endY) / 10.;
            CGFloat backPointY = endY + space;
            CGFloat advancePointY = endY - space;
            valueArray = @[[NSValue valueWithCGPoint:CGPointMake(X, startY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                           [NSValue valueWithCGPoint:CGPointMake(X, endY)]];
        }
            break;
        case WQKAnimationDerictionLeft:
        {
            CGFloat Y = startPoint.y;
            CGFloat startX = startPoint.x;
            CGFloat endX = endPoint.x;
            CGFloat space = (endX - startX) / 10.;
            CGFloat backPointx = endX - space;
            CGFloat advancePointx = endX + space;

            valueArray = @[[NSValue valueWithCGPoint:CGPointMake(startX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(advancePointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(backPointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(advancePointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(backPointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)]];
        }
            break;
        case WQKAnimationDerictionRight:
        {
            CGFloat Y = startPoint.y;
            CGFloat startX = startPoint.x;
            CGFloat endX = endPoint.x;
            CGFloat space = (startX - endX) / 10.;
            CGFloat backPointx = endX + space;
            CGFloat advancePointx = endX - space;
            
            valueArray = @[[NSValue valueWithCGPoint:CGPointMake(startX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(advancePointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(backPointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(advancePointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(backPointx, Y)],
                           [NSValue valueWithCGPoint:CGPointMake(endX, Y)]];
        }
            break;

            
        default:
            break;
    }
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.values = valueArray;
    keyFrameAnimation.duration = duration;
    keyFrameAnimation.keyTimes = @[@(0.0), @(0.65), @(0.7), @(0.75), @(0.80),
                                   @(0.85), @(0.9), @(0.95), @(0.97), @(0.99)];
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                        ];
    return keyFrameAnimation;
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
    return keyFrameAnimation;
}

- (CAAnimation *)flipAnimationViewWithX
{
    return [self flipAnimationViewWith:0];
}

- (CAAnimation *)flipViewWithXWithChangeContentBlock:(void (^)(void))changeBlock
{
    CATransform3D fromValue = CATransform3DMakeRotation(0, 1, 0, 0);
    CATransform3D toValue = CATransform3DMakeRotation(M_PI, 1, 0, 0);

    CASpringAnimation *springAnimation = (CASpringAnimation *)[self flipAnimationViewFrom:fromValue toValue:toValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(springAnimation.duration / 2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        changeBlock();
    });
    return springAnimation;
}

- (CAAnimation *)flipAnimationViewWithY
{
    return [self flipAnimationViewWith:1];
}

- (CAAnimation *)flipViewWithYWithChangeContentBlock:(void (^)(void))changeBlock
{
    CATransform3D fromValue = CATransform3DMakeRotation(0, 0, 1, 0);
    CATransform3D toValue = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    CASpringAnimation *springAnimation = (CASpringAnimation *)[self flipAnimationViewFrom:fromValue toValue:toValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(springAnimation.duration / 2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        changeBlock();
    });
    return springAnimation;
}

- (CAAnimation *)flipAnimationViewWithZ
{
    return [self flipAnimationViewWith:2];
}

/*
 * 0 : X轴翻转
 * 1 : Y轴翻转
 * 2 : Z轴翻转
 */
- (CAAnimation *)flipAnimationViewWith:(NSInteger)flag
{
    CATransform3D fromValue, toValue;
    switch (flag) {
        case 0:
            fromValue = CATransform3DMakeRotation(0, 1, 0, 0);
            toValue = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
            break;
        case 1:
            fromValue = CATransform3DMakeRotation(0, 0, 1, 0);
            toValue = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            break;
        case 2:
            fromValue = CATransform3DMakeRotation(0, 0, 0, 1);
            toValue = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            break;
 
        default:
            fromValue = CATransform3DMakeRotation(0, 0, 1, 0);
            toValue = CATransform3DMakeRotation(M_PI, 0, 1, 0);
            break;
    }
    CASpringAnimation *springAnimation = (CASpringAnimation *)[self flipAnimationViewFrom:fromValue toValue:toValue];
    return springAnimation;
}

- (CAAnimation *)flipAnimationViewFrom:(CATransform3D)fromValue toValue:(CATransform3D)toValue
{
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform"];
    springAnimation.mass = 18.; //该系数越小，动画弹性速度越快，
    springAnimation.damping = 2.2; //该系数越大，动画执行的时间越短
    springAnimation.stiffness = 50;//该系数越大，动画的执行越快次数越多
    [springAnimation setDelegate:self];
    springAnimation.cumulative = YES;
    springAnimation.removedOnCompletion = NO; //和下面的mode同时设置动画结束后不会从当前视图layer移除
    springAnimation.fillMode = kCAFillModeForwards;
    springAnimation.fromValue = [NSValue valueWithCATransform3D:fromValue];
    springAnimation.toValue = [NSValue valueWithCATransform3D:toValue];
    springAnimation.duration = 1;
    
    return springAnimation;
}

- (CAAnimationGroup *)groupAnimationWith:(NSArray <CAAnimation *>*)animations
{
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    CGFloat totleDuration = 0.0;
    for (NSInteger i = 0; i < animations.count; i++)
    {
        CAAnimation *ani = animations[i];
        if (i == 0)
        {
            totleDuration = ani.duration;
        }else
        {
            ani.beginTime = totleDuration;
            totleDuration = totleDuration + ani.duration;
            
        }
    }
    [groupAni setAnimations:animations];
    [groupAni setDuration:totleDuration];
    [self.layer addAnimation:groupAni forKey:@"Alex.GorupAnimation"];
    return groupAni;
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
