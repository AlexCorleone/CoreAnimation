//
//  WQKLayerView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WQKLayerViewGradientLayer,//colorLayer
    WQKLayerViewEmitterLayer,//
    WQKLayerViewShapeLayer,
    WQKLayerViewDefault,
} WQKLayerViewLayerType;

@interface WQKLayerView : UIView

@property WQKLayerViewLayerType layerType;

- (instancetype)initWithFrame:(CGRect)frame layerType:(WQKLayerViewLayerType)type;
@end
