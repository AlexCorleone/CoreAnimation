//
//  UIView+WQKAnimationView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WQKAnimationView)<CAAnimationDelegate>

//放大缩小
- (CAAnimation *)springAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration;
- (CAAnimation *)basicAnimationViewWith:(CGFloat)scale duration:(CGFloat)duration;

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

@end
