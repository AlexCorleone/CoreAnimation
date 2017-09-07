//
//  WQKAnimationView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/5.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKAnimationView.h"
#import "YSCWaterWaveView.h"
#import "UIView+WQKAnimationView.h"

@interface WQKAnimationView ()

@property (nonatomic, strong) UIImageView *springImageView;

@end
@implementation WQKAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:self.springImageView];
    }
    return self;
}

#pragma mark - setter && getter
- (UIImageView *)springImageView
{
    if (!_springImageView)
    {
        self.springImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spring_ThumbUp_Image"]];
        [_springImageView setFrame:self.bounds];
    }
    return _springImageView;
}

- (void)setAnimationType:(WQKAnimationViewType)animationType
{
    NSLog(@"%@", self.layer.animationKeys);
    switch (animationType) {
        case WQKAnimationViewGroup:
            [self WQKAnimationViewGroup];
            break;
        case WQKAnimationViewFlitX:
            [self WQKAnimationViewFlitX];
            break;
        case WQKAnimationViewFlitY:
            [self WQKAnimationViewFlitY];
            break;
        case WQKAnimationViewFlitZ:
            [self WQKAnimationViewFlitZ];
            break;
        case WQKAnimationViewBasicScale:
            [self WQKAnimationViewBasicScale];
            break;
 
        default:
            break;
    }
}

#pragma mark - private Method
- (void)WQKAnimationViewGroup
{
    CASpringAnimation *scaleAni = (CASpringAnimation *)[self springAnimationViewWith:1.4 duration:1];
    CAKeyframeAnimation *keyFrameAni = (CAKeyframeAnimation *)[self keyFrameAnimationWith:[self createKeyFramePath] duration:7];
    CASpringAnimation *flipAni = (CASpringAnimation *)[self flipAnimationViewWithY];
    [self groupAnimationWith:@[scaleAni, keyFrameAni, flipAni]];
}

- (void)WQKAnimationViewFlitX
{
    [self.layer addAnimation:[self flipAnimationViewWithX] forKey:@"Alex.FlipX"];
}
- (void)WQKAnimationViewFlitY
{
    [self.layer addAnimation:[self flipAnimationViewWithY] forKey:@"Alex.FlipY"];
}

- (void)WQKAnimationViewFlitZ
{
    [self.layer addAnimation:[self flipAnimationViewWithZ] forKey:@"Alex.FlipZ"];
}

- (void)WQKAnimationViewBasicScale
{
    [self.layer addAnimation:[self basicAnimationViewWith:1.5 duration:2] forKey:@"Alex.BasicScale"];

}

- (CGPathRef)createKeyFramePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat X = self.center.x;
    CGFloat Y = self.center.y;
    [path moveToPoint:self.center];
    [path addLineToPoint:CGPointMake(X + 100, Y)];
    [path addLineToPoint:CGPointMake(X + 100, Y + 100)];
    [path addLineToPoint:CGPointMake(X, Y + 100)];
    [path addLineToPoint:CGPointMake(X, Y)];
    return path.CGPath;
}

@end
