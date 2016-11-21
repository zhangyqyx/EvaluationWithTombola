//
//  ZYScratchView.h
//  刮刮乐
//
//  Created by 张永强 on 16/11/19.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYScratchView;
@protocol ZYScratchViewDelegate <NSObject>

- (void)scratchViewTextShow:(ZYScratchView *)view;

@end

@interface ZYScratchView : UIView

/** 代理 */
@property (nonatomic , weak)id<ZYScratchViewDelegate> delegate;

/**
 * 设置刮奖的视图
 * @param bgImage 背景图片
 * @param text 刮开后显示的文字
 * @param coverImage 遮盖图片(要刮的图片)
 * @param size 每次滑动清除的点的大小默认（10，10）
*/
- (void)scratchWithbgImage:(NSString *)bgImage withText:(NSString *)text withCoverImage:(NSString *)coverImage withSize:(CGSize)size;



@end
