//
//  ViewController.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/5.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKAnimationVC.h"
#import "WQKAnimationView.h"
#import "WQKLayerVC.h"
#import "UIView+WQKAnimationView.h"
#import "WQKAppDelegate.h"

@interface  WQKAnimationVC()<UITableViewDelegate, UITableViewDataSource>
{
}
@property (nonatomic, strong) UIImageView *animationImageView;

@property (nonatomic, strong) WQKAnimationView *animationView;

@property (nonatomic, strong) UITableView *animationTableView;

@property (nonatomic, strong) NSDictionary *animationDataArray;

@end

@implementation WQKAnimationVC

+(void)load
{
    
}
+(void)initialize
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Animation"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self configRightBarButtomItem];
//    WQKAppDelegate *delegate = (WQKAppDelegate *)[UIApplication sharedApplication].delegate;
//    [self.view insertSubview:delegate.backgountNavc.viewControllers.firstObject.view atIndex:0];
//    [self.navigationController addChildViewController:delegate.backgountNavc.viewControllers.firstObject];
//    [delegate.backgountNavc.viewControllers.firstObject.view removeFromSuperview];
//    [delegate.backgountNavc.viewControllers.firstObject removeFromParentViewController];
    [self.view insertSubview:self.animationView atIndex:1];
    [self.view insertSubview:self.animationTableView atIndex:0];
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

- (UITableView *)animationTableView
{
    if (!_animationTableView)
    {
        self.animationTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.animationView.frame), self.view.bounds.size.width - 20, self.view.bounds.size.height - CGRectGetMaxY(self.animationView.frame)) style:UITableViewStylePlain];
        [_animationTableView setDelegate:self];
        [_animationTableView setDataSource:self];
        _animationTableView.tableFooterView = [UIView new];
        _animationTableView.tableHeaderView = [UIView new];
    }
    return _animationTableView;
}

- (NSDictionary *)animationDataArray
{
    if (_animationDataArray == nil)
    {
        
        self.animationDataArray = @{@"X轴翻转" : @(WQKAnimationViewFlitX),
                                    @"Y轴翻转" : @(WQKAnimationViewFlitY),
                                    @"Z轴翻转" : @(WQKAnimationViewFlitZ),
                                    @"basic放大" : @(WQKAnimationViewBasicScale),
                                    @"组合动画" : @(WQKAnimationViewGroup),
                                    @"弹簧进入动画Left" : @(WQKAnimationViewSpringIntoLeft),
                                    @"弹簧进入动画Right" : @(WQKAnimationViewSpringIntoRight),
                                    @"弹簧进入动画Top" : @(WQKAnimationViewSpringIntoTop),
                                    @"弹簧进入动画Bottom" : @(WQKAnimationViewSpringIntoBottom)};
    }
    return _animationDataArray;
}

- (void)configRightBarButtomItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 80, 30)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"找灵感>>" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)rightBarButtonItemClick:(UIButton *)button
{
    WQKLayerVC *layerVC = [[WQKLayerVC alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:layerVC];
    layerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:navc animated:YES completion:nil];
}

#pragma marrk - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WQKAnimationViewType type = [[_animationDataArray valueForKey:_animationDataArray.allKeys[indexPath.row]] integerValue];
    [self.animationView setAnimationType:type];
}

#pragma marrk - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animationDataArray.allKeys.count;
}

static NSString * const cellIdentifier = @"cellidentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *bGView = [[UIView alloc] initWithFrame:cell.bounds];
        [bGView setBackgroundColor:[UIColor purpleColor]];
        [cell setSelectedBackgroundView:bGView];
    }
    cell.textLabel.text = _animationDataArray.allKeys[indexPath.row];
    return cell;
}

- (UIImage *)captureImageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    return image;
}

- (void)configScaleVC
{
    [_animationView.layer addAnimation:[_animationView basicAnimationViewWith:0.9 duration:0.5] forKey:@"Alex.BasicScaleSmall"];
    [_animationView.layer addAnimation:[_animationView basicAnimationViewWith:1.1 duration:0.5] forKey:@"Alex.BasicScaleLage"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
