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

@property (nonatomic, strong) YSCWaterWaveView *waterWave;
@property (nonatomic, strong) UIImageView *springImageView;

@end
@implementation WQKAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor lightTextColor]];
//        [self configWaveView];
        [self addSubview:self.springImageView];
    }
    return self;
}

- (void)configWaveView
{
    //show
    [self addSubview:self.waterWave];
    [self.waterWave startWave];
}

- (YSCWaterWaveView *)waterWave
{
    if (!_waterWave) {
        self.waterWave = [[YSCWaterWaveView alloc] init];
        _waterWave.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _waterWave.layer.cornerRadius = _waterWave.frame.size.width / 2.;
        _waterWave.layer.borderColor = [UIColor whiteColor].CGColor;
        _waterWave.layer.borderWidth = 0.8;
        _waterWave.percent = 0.3;
        _waterWave.firstWaveColor = [UIColor colorWithRed:146/255.0 green:148/255.0 blue:216/255.0 alpha:1.0];
        _waterWave.secondWaveColor = [UIColor colorWithRed:84/255.0 green:87/255.0 blue:197/255.0 alpha:1.0];
    }
    
    return _waterWave;
}

- (UIImageView *)springImageView
{
    if (!_springImageView)
    {
        self.springImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spring_ThumbUp_Image"]];
        [_springImageView setFrame:self.bounds];
//        [_springImageView setBackgroundColor:[UIColor lightGrayColor]];
        [_springImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumpUpImageTap:)];
        [_springImageView addGestureRecognizer:tapGesture];
    }
    return _springImageView;
}

#pragma mark - private Method
- (void)thumpUpImageTap:(UIGestureRecognizer *)gesture
{
    [self springAnimationViewWith:1.4 duration:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self keyFrameAnimationWith:[self createKeyFramePath] duration:7];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self flipAnimationView];
    });
    
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
