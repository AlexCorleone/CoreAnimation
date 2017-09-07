//
//  WQKLayerView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/6.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 *CALayer :
 *          Text, Shapes, and Gradients :
 *                                      CATextLayer
 *                                      CAShapLayer
 *                                      CAGradientLayer
 *          Particle Systems :
 *                          CAEmitterLayer  配合CAEmitterCell
 *          Advanced Layer Options :
 *                                  CAScrollerLayer
 *                                  CATiledLayer
 *                                  CATransformLayer
 *                                  CAReplicatorLayer
 *          Metal and OpenGL :
 *                          CAMetalLayer
 *                          CAMetalDrawable
 *                          CAEAGLLayer
 *                          CAOpenGLLayer
 *                          CARenderer
 *
 */

typedef enum : NSUInteger {
    WQKLayerViewGradientLayer,//colorLayer
    WQKLayerViewEmitterLayer,//
    WQKLayerViewShapeLayer,
    WQKLayerViewTransformLayer,//3dLayer
    WQKLayerViewDefault,
} WQKLayerViewLayerType;

@interface WQKLayerView : UIView

@property WQKLayerViewLayerType layerType;

- (instancetype)initWithFrame:(CGRect)frame layerType:(WQKLayerViewLayerType)type;

@end
