//
//  ZYStarView.m
//  五星好评
//
//  Created by 张永强 on 16/11/18.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import "ZYStarView.h"
#import "UIView+Extension.h"

@interface ZYStarView ()
/** 第一颗星星 */
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImage;
/** 第二颗星星 */
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImage;
/** 第三颗星星 */
@property (weak, nonatomic) IBOutlet UIImageView *threeStarImage;
/** 第四颗星星 */
@property (weak, nonatomic) IBOutlet UIImageView *fourStarImage;
/** 第五颗星星 */
@property (weak, nonatomic) IBOutlet UIImageView *fiveStarImage;
/** 是否添加星星 */
@property (nonatomic , assign)BOOL isAddStar;

@end


@implementation ZYStarView



//加载星星视图
+ (instancetype)loadStarView{
    ZYStarView *starView = [[[UINib nibWithNibName:@"ZYStarView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    return starView;
}
//设置默认星星的图片
- (void)setNormalStr:(NSString *)normalStr {
    _normalStr = normalStr;
    if (!self.normalStr) {
        self.normalStr = @"StarNormal";
    }
    self.firstStarImage.image = [UIImage imageNamed:self.normalStr];
    self.secondStarImage.image = [UIImage imageNamed:self.normalStr];
    self.threeStarImage.image = [UIImage imageNamed:self.normalStr];
    self.fourStarImage.image = [UIImage imageNamed:self.normalStr];
    self.fiveStarImage.image = [UIImage imageNamed:self.normalStr];
}

//点击的位置判断是否添加星星
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches  anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.x >= self.firstStarImage.x && point.x <= (self.width) && (point.y > self.firstStarImage.y & point.y< self.height )) {
        self.isAddStar = YES;
    }else {
        self.isAddStar = NO;
    }
}
//移动到的位置，添加星星
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(self.isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
}
//结束的时候，添加星星
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(self.isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    self.isAddStar = NO;
}


//添加星星计算分数
- (void)setStarForegroundViewWithPoint:(CGPoint)point {
    //添加星星
    float score = 0;
    score += [self changeImg:point.x image:self.firstStarImage];
    score += [self changeImg:point.x image:self.secondStarImage];
    score += [self changeImg:point.x image:self.threeStarImage];
    score += [self changeImg:point.x image:self.fourStarImage];
    score += [self changeImg:point.x image:self.fiveStarImage];
    if (score == 0) {
        score = 0.5;
        if (!self.halfImageStr) {
            self.halfImageStr = @"StarSelectHalf";
        }
        [self.firstStarImage setImage:[UIImage imageNamed:self.halfImageStr]];
    }
    self.score = score;
}

//设置添加多少个星星
-(CGFloat)changeImg:(float)x image:(UIImageView*)imgView{
    if (!self.normalStr) {
        self.normalStr = @"StarNormal";
    }
    if (!self.selectStr) {
        self.selectStr = @"StarSelected";
    }
    if (!self.halfImageStr) {
        self.halfImageStr = @"StarSelectHalf";
    }

    if(x > (imgView.x + imgView.width/2)){
        imgView.image =  [UIImage imageNamed:self.selectStr];
        return 1;
    }else if(x > imgView.x){
        imgView.image =  [UIImage imageNamed:self.halfImageStr];
        return 0.5;
    }else{
        imgView.image =  [UIImage imageNamed: self.normalStr];
        return 0;
    }
}





@end
