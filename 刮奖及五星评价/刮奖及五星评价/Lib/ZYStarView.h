//
//  ZYStarView.h
//  五星好评
//
//  Created by 张永强 on 16/11/18.
//  Copyright © 2016年 LDWL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYStarView : UIView
/** 加载视图 */
+ (instancetype)loadStarView;
/** 默认星星的图片 */
@property (nonatomic , copy)NSString *normalStr;
/** 选中星星的图片 */
@property (nonatomic , copy)NSString *selectStr;
/** 选了一半的星星的图片 */
@property (nonatomic , copy)NSString *halfImageStr;
/** 得到的评价的分数 */
@property (nonatomic , assign,)float score;


@end
