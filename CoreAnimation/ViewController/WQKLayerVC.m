//
//  WQKLayerVC.m
//  CoreAnimation
//
//  Created by AlexCorleone on 2017/9/7.
//  Copyright © 2017年 魏乾坤. All rights reserved.
//

#import "WQKLayerVC.h"
#import "WQKLayerView.h"

@interface WQKLayerVC ()

@property (nonatomic, strong) WQKLayerView *layerView;

@end

@implementation WQKLayerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Layer"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.layerView];
}

#pragma mark - setter && getter
- (WQKLayerView *)layerView
{
    if (!_layerView)
    {
        self.layerView = [[WQKLayerView alloc] initWithFrame:CGRectMake(10, 150, self.view.bounds.size.width - 20, self.view.bounds.size.height - 150 - 20)];
        
    }
    return _layerView;
}

- (void)dealloc
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
