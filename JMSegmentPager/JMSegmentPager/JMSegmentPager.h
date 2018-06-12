//
//  JMSegmentPager.h
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMSegmentTitleConfig.h"

@interface JMSegmentPager : UIView

//+ (instancetype)segmentPagerWithTitleArray:(NSArray *)titleArray TitleConfigBlock:(void(^)(JMSegmentTitleConfig *))titleConfigBlock;

- (instancetype)initWithSegmentPagerWithTitleConfig:(JMSegmentTitleConfig *)titleConfig;

@property (nonatomic, assign) NSInteger titleSelectIndex;

/**
 添加自定义View, 自定义view的点击事件只能自己处理

 @param customView 自定义视图(注意, 目前不支持插入自定义button)
 @param atIndex 插入的下标
 */
- (void)addCustomView:(UIView *)customView AtIndex:(NSInteger)atIndex;

@end













