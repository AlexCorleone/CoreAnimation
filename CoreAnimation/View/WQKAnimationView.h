//
//  WQKAnimationView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/5.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WQKAnimationViewGroup,
    WQKAnimationViewFlitX,
    WQKAnimationViewFlitY,
    WQKAnimationViewFlitZ,
    WQKAnimationViewBasicScale
} WQKAnimationViewType;
@interface WQKAnimationView : UIView

@property (nonatomic, assign) WQKAnimationViewType animationType;

@end
