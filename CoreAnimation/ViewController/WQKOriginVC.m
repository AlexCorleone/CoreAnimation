//
//  ViewController.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/5.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKOriginVC.h"
#import "WQKAnimationView.h"
#import "WQKLayerView.h"

@interface  WQKOriginVC()<CAAnimationDelegate>

@property (nonatomic, strong) WQKAnimationView *animationView;

@property (nonatomic, strong) WQKLayerView *layerView;

@end

@implementation WQKOriginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightTextColor]];
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.layerView];
}

- (WQKAnimationView *)animationView
{
    if (!_animationView)
    {
        self.animationView = [[WQKAnimationView alloc] initWithFrame:CGRectMake(100, 100, 35, 35)];
        [_animationView.layer setCornerRadius:35 / 2.];
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromTop;
        [_animationView.layer addAnimation:transition forKey:@"transitionAnimation"];
    }
    return _animationView;
}

- (WQKLayerView *)layerView
{
    if (!_layerView)
    {
        self.layerView = [[WQKLayerView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.animationView.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height - CGRectGetMaxY(self.animationView.frame))];
        
    }
    return _layerView;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
