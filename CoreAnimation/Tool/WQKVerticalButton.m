//
//  WQKVerticalButton.m
//  AboutAnimation
//
//  Created by AlexCorleone on 2017/9/25.
//  Copyright © 2017年 AlexCorleone. All rights reserved.
//

#import "WQKVerticalButton.h"

@implementation WQKVerticalButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    WQKVerticalButton *verticalButton = [super buttonWithType:buttonType];
    [verticalButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [verticalButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [verticalButton.titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    return verticalButton;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat height = self.bounds.size.height;
    CGPoint origin = [self caculateOriginPoint];
    CGFloat originX = origin.x;
    CGFloat originY = origin.y;
    return CGRectMake(originX, CGRectGetMaxY(self.imageView.frame) + 1, CGRectGetWidth(self.imageView.bounds), (height - originY * 2) / 4. * 1);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    CGPoint origin = [self caculateOriginPoint];
    CGFloat originX = origin.x;
    CGFloat originY = origin.y;
    return CGRectMake(originX, originY - 1, width - originX * 2, (height - originY * 2) / 4. * 3);
}

- (CGPoint)caculateOriginPoint
{
    //sqrt(<#double#>)平方根
    //pow(<#double#>, <#double#>)幂次方
    CGFloat originX = 0;
    CGFloat originY = 0;
    if (self.layer.cornerRadius < self.bounds.size.width/ 2)
    {
        originX = self.layer.cornerRadius * sqrt(2) - self.layer.cornerRadius;
        originY = self.layer.cornerRadius * sqrt(2) - self.layer.cornerRadius - 3;
    }else
    {
        originX = self.layer.cornerRadius * sqrt(2) - self.layer.cornerRadius;
        originY = self.layer.cornerRadius * sqrt(2) - self.layer.cornerRadius - 3;
    }
    return CGPointMake(originX, originY);
}

@end
