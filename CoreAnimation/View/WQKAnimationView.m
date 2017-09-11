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
        [self setBackgroundColor:[UIColor purpleColor]];
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
        [_springImageView setContentMode:UIViewContentModeScaleToFill];
        [_springImageView setFrame:self.bounds];
    }
    return _springImageView;
}

- (void)setAnimationType:(WQKAnimationViewType)animationType
{
    NSLog(@"%@", self.layer.animationKeys);
    [self beginAndResetAnimation];
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
    [self.layer addAnimation:[self flipViewWithXWithChangeContentBlock:^{
        [self.springImageView setImage:[UIImage imageNamed:@"spring_UnthumbUp_Image"]];
    }] forKey:@"Alex.FlipX"];
}
- (void)WQKAnimationViewFlitY
{
    [self.layer addAnimation:[self flipViewWithYWithChangeContentBlock:^{
        [self.springImageView setImage:[UIImage imageNamed:@"spring_UnthumbUp_Image"]];
        self.springImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    }] forKey:@"Alex.FlipY"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.springImageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    });
}

- (void)WQKAnimationViewFlitZ
{
    [self.layer addAnimation:[self flipAnimationViewWithZ] forKey:@"Alex.FlipViewZ"];
}

- (void)WQKAnimationViewBasicScale
{
//    [self.layer addAnimation:[self.springImageView basicAnimationViewWith:1.1 duration:1] forKey:@"Alex.BasicViewScale"];
    [self.springImageView.layer addAnimation:[self.springImageView basicAnimationViewWith:1.1 duration:1] forKey:@"Alex.BasicImageScale"];
}

- (void)beginAndResetAnimation
{
    [self.layer removeAllAnimations];
    self.layer.transform = CATransform3DIdentity;
    [self.springImageView.layer removeAllAnimations];
    self.springImageView.layer.transform = CATransform3DIdentity;
    [self.springImageView setImage:[UIImage imageNamed:@"spring_ThumbUp_Image"]];
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
