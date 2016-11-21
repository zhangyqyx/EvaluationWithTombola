//
//  ZYScratchView.m
//  刮刮乐
//
//  Created by 张永强 on 16/11/19.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import "ZYScratchView.h"
#import "UIView+Extension.h"

@interface ZYScratchView ()
/** 文字 */
@property (nonatomic , strong)UILabel *textLabel;

@end

@implementation ZYScratchView

static UIImageView *coverImageView;
static CGSize pointSize;

- (void)scratchWithbgImage:(NSString *)bgImage withText:(NSString *)text withCoverImage:(NSString *)coverImage withSize:(CGSize)size {
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    bgImageView.image = [UIImage imageNamed:bgImage];
    [self addSubview:bgImageView];
    self.textLabel = [[UILabel alloc] init];
    _textLabel.text = text;
    _textLabel.numberOfLines = 0;
    CGSize fitSize = [_textLabel sizeThatFits:CGSizeMake(self.width - 20, self.height - self.center.y)];
    _textLabel.frame = CGRectMake(self.center.x - fitSize.width * 0.5, self.center.y - fitSize.height * 0.5 + 50, fitSize.width, fitSize.height);
    [self addSubview:_textLabel];
    UIImageView *cover = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.width - 100,(self.width - 100) * 0.4)];
    cover.image = [UIImage imageNamed:coverImage];
    cover.center = _textLabel.center;
    [self addSubview:cover];
    coverImageView = cover;
    pointSize = size;
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //得到移动时候的点
    UITouch *touch = [touches anyObject];
    CGPoint contentPoint = [touch locationInView:coverImageView];
    //清除的大小
    CGRect rect = CGRectZero;
    if (pointSize.width) {
       rect = CGRectMake(contentPoint.x, contentPoint.y, pointSize.width, pointSize.height);
    }else{
       rect = CGRectMake(contentPoint.x, contentPoint.y, 10, 10);
    }
    //得到图片的一个视图
    UIGraphicsBeginImageContextWithOptions(coverImageView.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //将图片映射到上下文中
    [coverImageView.layer renderInContext:ref];
    //清除划过的区域
    CGContextClearRect(ref, rect);
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    coverImageView.image = image;
}

//点击结束，判断文字的四个角是否都完全显示出来
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   CGPoint leftTopPoint =  [self convertPoint:_textLabel.frame.origin toView:coverImageView];
   CGPoint leftBottomPoint = [self convertPoint:CGPointMake(_textLabel.frame.origin.x, _textLabel.y + _textLabel.height * 0.5) toView:coverImageView];
    CGPoint rightTopPoint =  [self convertPoint:CGPointMake(_textLabel.x +_textLabel.width * 0.5, _textLabel.y) toView:coverImageView];
    CGPoint rightBottomPoint = [self convertPoint:CGPointMake(_textLabel.x +_textLabel.width * 0.5, _textLabel.y + _textLabel.height * 0.5) toView:coverImageView];
    if ([self isOpaqueWithPoint:leftTopPoint]&&[self isOpaqueWithPoint:leftBottomPoint]&&[self isOpaqueWithPoint:rightBottomPoint]&&[self isOpaqueWithPoint:rightTopPoint]) {
        if ([self.delegate respondsToSelector:@selector(scratchViewTextShow:)]) {
            [self.delegate scratchViewTextShow:self];
        }
    }
}
//判断某个点是否透明
-(BOOL)isOpaqueWithPoint:(CGPoint)point{
    unsigned char pixel[1]={0};
    CGContextRef context = CGBitmapContextCreate(pixel,1,1,8,1,NULL,kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [coverImageView.image drawAtPoint: CGPointMake(-point.x,-point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    BOOL transparent = alpha<0.01f;
    return transparent;
}



@end















