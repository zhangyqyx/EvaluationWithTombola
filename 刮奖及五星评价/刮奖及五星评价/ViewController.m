//
//  ViewController.m
//  刮奖及五星评价
//
//  Created by 张永强 on 16/11/21.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import "ViewController.h"
#import "ZYStarView.h"
#import "UIView+Extension.h"
#import "ZYScratchViewController.h"

@interface ViewController ()
/** 星星视图 */
@property (nonatomic , strong)ZYStarView *starView;
/** 显示分数 */
@property (nonatomic , strong)UILabel *scoreLabel;
/** 刮奖的文字输入框 */
@property (nonatomic , strong)UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置星星视图
    self.starView = [ZYStarView loadStarView];
    _starView.frame = CGRectMake(30, 100, 200, 70);
    _starView.normalStr = @"normal";
    _starView.selectStr = @"select";
    _starView.halfImageStr = @"half";
    [self.view addSubview:_starView];
    //点击按钮显示分数
    UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scoreButton.backgroundColor = [UIColor redColor];
    [scoreButton setTitle:@"分数" forState:UIControlStateNormal];
    scoreButton.frame = CGRectMake(50, 200, 50, 20);
    [scoreButton addTarget:self action:@selector(showScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scoreButton];
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 200, 60, 20)];
    [self.view addSubview:_scoreLabel];
    //设置刮刮乐界面
   self.textField = [[UITextField alloc] initWithFrame:CGRectMake(_starView.x, scoreButton.y + 40, 200, 25)];
    _textField.placeholder = @"请输入刮奖内容";
    [self.view addSubview:_textField];
    //跳转刮奖界面按钮
    UIButton *scratchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scratchButton.backgroundColor = [UIColor redColor];
    [scratchButton setTitle:@"去刮奖" forState:UIControlStateNormal];
    scratchButton.frame = CGRectMake(scoreButton.x,_textField.y + 30, 60, 20);
    [scratchButton addTarget:self action:@selector(gotoscratchVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scratchButton];
    
}
//显示旋转星星的得分
- (void)showScore {
    _scoreLabel.text = [NSString stringWithFormat:@"%.1lf分" , _starView.score];
}

//去刮奖界面
- (void)gotoscratchVC {
    ZYScratchViewController *scratchVc = [[ZYScratchViewController alloc] init];
    scratchVc.text = _textField.text;
    [self presentViewController:scratchVc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
