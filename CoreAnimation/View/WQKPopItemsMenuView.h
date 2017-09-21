//
//  WQKPopItemsMenuView.h
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/21.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQKPopItemsMenuView : UIView

@property (nonatomic, strong) NSArray <NSString *>*titleArray;

@property (nonatomic, copy) void(^itemClickBlock)(id targetItem, NSUInteger index);

- (void)isShowBtnAray:(BOOL)flag;

@end
