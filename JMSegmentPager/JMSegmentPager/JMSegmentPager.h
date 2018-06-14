//
//  JMSegmentPager.h
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMSegmentTitleConfig.h"
#import "JMSegmentContentConfig.h"

@protocol JMSegmentPagerDelegate<NSObject>


/**
 点击标题的时候回调
 @param title 返回标题文字
 @param index 返回对应的下标
 */
- (void)JMSegmentPagerTitle:(NSString *)title Index:(NSInteger)index;

@end

@interface JMSegmentPager : UIView

/**
 初始化方法

 @param titleConfig 标题视图的配置文件
 @param contentConfig 内容视图的配置文件
 @param delegate 代理
 @return segmentPager
 */
- (instancetype)initWithSegmentPagerWithTitleConfig:(JMSegmentTitleConfig *)titleConfig ContentConfig:(JMSegmentContentConfig *)contentConfig Delegate:(id<JMSegmentPagerDelegate>)delegate;

/** 代理属性 */
@property (nonatomic, weak) id <JMSegmentPagerDelegate>delegate;
@property (nonatomic, assign) NSInteger titleSelectIndex;

/**
 添加自定义View, 自定义view的点击事件只能自己处理

 @param customView 自定义视图
 @param atIndex 插入的下标 (如果插入的下标越界, 将会添加到最后一个)
 */
- (void)addCustomView:(UIView *)customView AtIndex:(NSInteger)atIndex;

@end


@interface JMSegmentButton : UIButton
@end












