//
//  WQKPopItemsMenuView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/21.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKPopItemsMenuView.h"

#define tagBaseFlage 10000
@interface WQKPopItemsMenuView ()

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;

@end

@implementation WQKPopItemsMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

#pragma mark - Private Method

- (void)setTitleArray:(NSArray<NSString *> *)titleArray
{
    _titleArray = titleArray;
    [self createBtnArray];
}

- (NSArray *)createBtnArray
{
    NSUInteger cout = 4;
    NSArray <NSString *>*titleArray = self.titleArray;
    NSArray <UIColor *> *bgColorArray = @[[UIColor purpleColor], [UIColor brownColor],
                                          [UIColor lightGrayColor], [UIColor orangeColor],
                                          [UIColor orangeColor], [UIColor yellowColor],
                                          [UIColor brownColor], [UIColor purpleColor]
                                          ];
    
    self.btnArray = [[NSMutableArray alloc] initWithCapacity:titleArray.count];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat space = 30;
    CGFloat bottomSapce = 150;
    NSUInteger totleNumber = titleArray.count / cout;
    CGFloat btnWith = (screenWidth - (cout + 1) * space) / 4.;
    for (NSInteger i = 0; i < titleArray.count; i++)
    {
        NSUInteger levelNumber = i % cout;
        NSUInteger verticalNumber = i / cout;
        CGFloat X = (space + btnWith) * levelNumber + space;
        CGFloat Y = (screenHeight - bottomSapce) - ((totleNumber - (verticalNumber + 1)) * space + btnWith * (totleNumber - verticalNumber));
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [tempBtn setFrame:CGRectMake(X, Y, btnWith, btnWith)];
        [tempBtn setBackgroundColor:bgColorArray[i]];
        [tempBtn.layer setCornerRadius:btnWith / 2.];
        [tempBtn setClipsToBounds:YES];
        [tempBtn setHidden:YES];
        [tempBtn setTag:tagBaseFlage + i];
        [tempBtn addTarget:self
                    action:@selector(itemBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:tempBtn];
        [_btnArray addObject:tempBtn];
    }
    return _btnArray;
}

#pragma mark - Public Method
- (void)isShowBtnAray:(BOOL)flag
{
    
    for (UIButton *btn in self.btnArray)
    {
        NSString *animationKey = [NSString stringWithFormat:@"Alex.Group %ld", btn.tag];
        [btn.layer removeAnimationForKey:animationKey];
        if (!flag)
        {
            CAKeyframeAnimation *animation = (CAKeyframeAnimation *)[self springIntoAnimationViewWith:WQKAnimationDerictionTop startPoint:CGPointMake(btn.center.x, btn.center.y + 100) endPoint:btn.center duration:0.6];
            animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.53 :0.35 :0.83 :0.47];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(((btn.tag - tagBaseFlage) * 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [btn setHidden:flag];
                [btn.layer addAnimation:animation forKey:animationKey];
            });
        }else
        {
            CAKeyframeAnimation *animation = (CAKeyframeAnimation *)[self springIntoAnimationViewWith:WQKAnimationDerictionBottom startPoint:btn.center endPoint:CGPointMake(btn.center.x, btn.center.y + 100) duration:0.6];
            animation.calculationMode = kCAAnimationPaced;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(((_btnArray.count + tagBaseFlage - btn.tag) * 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [btn.layer addAnimation:animation forKey:animationKey];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [btn setHidden:flag];
                });
            });
        }
    }
}

- (CAKeyframeAnimation *)springIntoAnimationViewWith:(WQKAnimationDerictionType)directionType
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint
                                    duration:(NSTimeInterval)duration
{
    CGFloat X = startPoint.x;
    CGFloat startY = startPoint.y;
    CGFloat endY = endPoint.y;
    CGFloat space = (endY - startY) / 10.;
    CGFloat backPointY = endY - space;
    CGFloat advancePointY = endY + space;
    NSArray *valueArray = @[[NSValue valueWithCGPoint:CGPointMake(X, startY)],
                   [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                   [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                   [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                   [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                   [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                   //                           [NSValue valueWithCGPoint:CGPointMake(X, advancePointY)],
                   //                           [NSValue valueWithCGPoint:CGPointMake(X, endY)],
                   //                           [NSValue valueWithCGPoint:CGPointMake(X, backPointY)],
                   //                           [NSValue valueWithCGPoint:CGPointMake(X, endY)]
                   ];
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.values = valueArray;
    keyFrameAnimation.duration = duration;
    
    return keyFrameAnimation;
}

- (void)itemBtnClick:(UIButton *)btn
{
    if (self.itemClickBlock)
    {
        [self isShowBtnAray:YES];
        self.itemClickBlock(btn, btn.tag - tagBaseFlage);
    }
}
@end
