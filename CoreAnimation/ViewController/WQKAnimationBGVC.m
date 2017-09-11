//
//  WQKAnimationBGVC.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/11.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKAnimationBGVC.h"
#import "WQKAppDelegate.h"
#import "UIView+WQKAnimationView.h"

@interface WQKAnimationBGVC ()

@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation WQKAnimationBGVC

+(void)load
{
    
}
+(void)initialize
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"backGround VC"];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    [self configRightBarButtomItem];
}

- (void)configRightBarButtomItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 95, 30)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"<<即将启程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBarButtonItemClick:(UIButton *)button
{
    [self currentViewAnimation];
    //    WQKLayerVC *layerVC = [[WQKLayerVC alloc] init];
    //    [self.navigationController pushViewController:layerVC animated:YES];
}

- (void)currentViewAnimation
{
    WQKAppDelegate *delegate = (WQKAppDelegate *)[UIApplication sharedApplication].delegate;
    UIImage *fogrontImage;
    UIImage *backGroundImage;
    backGroundImage = [UIImage imageNamed:@"flip_Forground_Image"];//[self captureImageFromLayer:delegate.fogrountNavc.navigationController.view.layer];
    fogrontImage = [UIImage imageNamed:@"flip_BackGround_Image"];//[self captureImageFromLayer:delegate.backgountNavc.navigationController.view.layer];
    __weak typeof(self)weakSelf = self;
    self.navigationController.view.alpha = 0.;
    if (!_animationImageView)
    {
        self.animationImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    [_animationImageView.layer removeAllAnimations];
    [_animationImageView setImage:fogrontImage];
    [[UIApplication sharedApplication].keyWindow addSubview:_animationImageView];
    _animationImageView.layer.transform = CATransform3DIdentity;
    CAAnimation *animation = [_animationImageView flipViewWithYWithChangeContentBlock:^{
        [_animationImageView setImage:backGroundImage];
        //        self.animationImageView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
    }];
    [_animationImageView.layer addAnimation:animation forKey:@"Alex.FlipAnimationVCY"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_animationImageView removeFromSuperview];
        [delegate switchRootVCWith:YES];
        weakSelf.navigationController.view.alpha = 1.;
        //        self.animationImageView.layer.transform = CATransform3DMakeScale(0.9, 0.9, -30.);
    });
    //    self.animationImageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    //    self.animationImageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
