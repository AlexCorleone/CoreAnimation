//
//  WQKLayerView.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKLayerView.h"

@interface WQKLayerView ()

@property (nonatomic, strong) UIBezierPath *circlePath;

@end

@implementation WQKLayerView

- (instancetype)initWithFrame:(CGRect)frame layerType:(WQKLayerViewLayerType)type;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        switch (type)
        {
            case WQKLayerViewGradientLayer:
            {
                [self configGradientLayer];
            }
                break;
            case WQKLayerViewShapeLayer:
            {
                [self configShapLayer];
            }
            case WQKLayerViewEmitterLayer:
            {
                [self configEmitterLayer];
            }
                break;
            case WQKLayerViewDefault:
            {
                
            }
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame layerType:WQKLayerViewEmitterLayer];
}

- (void)configGradientLayer
{
    //注意如果colors之给定一个颜色，没有效果显示
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [gradientLayer setFrame:CGRectMake(0, 10, self.bounds.size.width, 100)];
    [gradientLayer setColors:@[(id)[UIColor redColor].CGColor,
                               (id)[UIColor purpleColor].CGColor,
                               (id)[UIColor orangeColor].CGColor,
                               (id)[UIColor lightGrayColor].CGColor]];
    [gradientLayer setLocations:@[@(0.1), @(0.3), @(0.5), @(0.8)]];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 1)];
    [self.layer addSublayer:gradientLayer];
}

- (void)configShapLayer
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSArray *pointArray = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],
                            [NSValue valueWithCGPoint:CGPointMake(100, 130)],
                            [NSValue valueWithCGPoint:CGPointMake(150, 150)],
                            [NSValue valueWithCGPoint:CGPointMake(170, 130)],
                            [NSValue valueWithCGPoint:CGPointMake(170, 100)],
                            [NSValue valueWithCGPoint:CGPointMake(150, 80)],
                            [NSValue valueWithCGPoint:CGPointMake(100, 100)]];
    [path moveToPoint:CGPointMake(100, 100)];
    for (NSValue *pointValue in pointArray)
    {
        [path addLineToPoint:pointValue.CGPointValue];
    }
//    [path addArcWithCenter:CGPointMake(200, 200) radius:self.bounds.size.width / 2. / 4 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    self.circlePath = path;
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    [shapLayer setFrame:self.bounds];
    [shapLayer setPath:path.CGPath];
//    [shapLayer setBorderColor:[UIColor purpleColor].CGColor];
//    [shapLayer setBorderWidth:1.2];
    [shapLayer setFillColor:[UIColor lightGrayColor].CGColor];
    [shapLayer setLineWidth:1.2];
    [self.layer addSublayer:shapLayer];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if ([self.circlePath containsPoint:point])
//    {
//        NSLog(@"点击了线(图形)内");
//        return self;
//    }
//    NSLog(@"点击了线(图形)外");
//    return nil;
//}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//}

- (void)configEmitterLayer
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:emitterLayer];
    [emitterLayer setFrame:self.bounds];
//    emitterLayer.speed = arc4random();
    emitterLayer.emitterSize = CGSizeMake(20, 20);
    emitterLayer.emitterPosition = CGPointMake(150, 200);
    emitterLayer.emitterMode = kCAEmitterLayerVolume;
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.color = [UIColor lightGrayColor].CGColor;
    cell.birthRate = 1;
    cell.scale = 0.3; //离子的大小比例
    cell.lifetime = 3.0;//离子生命时间
    cell.alphaSpeed = -0.4; //离子隐藏的速度
    cell.velocity = 50;//初始速度
    cell.velocityRange = 70; //速度范围
    cell.emissionRange = 1.; //设置离子发射的角度
    cell.contents = (__bridge id)[UIImage imageNamed:@"spring_ThumbUp_Image"].CGImage;
    [emitterLayer setEmitterCells:@[cell]];
    [emitterLayer setTransform:CATransform3DMakeRotation(-70, 0, 0, 1)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [emitterLayer removeFromSuperlayer];
        NSLog(@"粒子发送结束");
    });
    
}


@end
