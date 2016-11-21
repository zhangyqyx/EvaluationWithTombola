//
//  ZYScratchViewController.m
//  刮奖及五星评价
//
//  Created by 张永强 on 16/11/21.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import "ZYScratchViewController.h"
#import "ZYScratchView.h"

@interface ZYScratchViewController ()<ZYScratchViewDelegate>

@end

@implementation ZYScratchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置刮刮乐视图
    ZYScratchView *scratchView = [[ZYScratchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scratchView.delegate = self;
    [scratchView scratchWithbgImage:@"bg" withText:_text withCoverImage:@"Latombola" withSize:CGSizeMake(20, 20)];
    [self.view addSubview:scratchView];
    //返回按钮
    UIButton *scratchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scratchButton setTitle:@"返回" forState:UIControlStateNormal];
    [scratchButton setTitleColor:[UIColor colorWithRed:250/255.0 green:242/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
    scratchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    scratchButton.frame = CGRectMake(0,20, 60, 20);
    [scratchButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scratchButton];
    
    
}
//文字已经显示出来
- (void)scratchViewTextShow:(ZYScratchView *)view {
    NSLog(@"文字已完全显示出来了");
}

//返回上一个界面
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
