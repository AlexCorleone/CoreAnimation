//
//  UIView+WQKAnimationView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WQKAnimationDerictionType) {
    WQKAnimationDerictionLeft,
    WQKAnimationDerictionTop,
    WQKAnimationDerictionRight,
    WQKAnimationDerictionBottom
};
@interface UIView (WQKAnimationView)<CAAnimationDelegate>

//放大缩小
- (CAAnimation *)springAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration;
- (CAAnimation *)basicAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration;

//弹簧进入 keyFrame实现
- (CAAnimation *)springIntoAnimationViewWith:(WQKAnimationDerictionType)directionType
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint
                                    duration:(NSTimeInterval)duration;

//曲线移动
- (CAAnimation *)keyFrameAnimationWith:(CGPathRef)path
                              duration:(CGFloat)duration;
//翻转视图 - > 左右翻转 Y翻转
- (CAAnimation *)flipAnimationViewWithY;
- (CAAnimation *)flipViewWithYWithChangeContentBlock:(void(^)(void))changeBlock;

- (CAAnimation *)flipAnimationViewWithX;
- (CAAnimation *)flipViewWithXWithChangeContentBlock:(void(^)(void))changeBlock;

- (CAAnimation *)flipAnimationViewWithZ;

- (CAAnimationGroup *)groupAnimationWith:(NSArray <CAAnimation *>*)animations;

- (CAAnimation *)transitionAnimation;

@end
