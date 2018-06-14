//
//  JMSegmentTitleConfig.h
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMSegmentIndicatorType) {  //指示器类型枚举
    JMSegmentIndicatorTypeDefault, //默认与按钮长度相同
    JMSegmentIndicatorTypeEqualTitle, //与文字长度相同
};

typedef NS_ENUM(NSInteger, JMSegmentTitleType) { //标题样式类型
    JMSegmentTitleTypeIndicatorBottom,  //默认指示器类型(指示器在底部)
};

@interface JMSegmentTitleConfig : NSObject

/**
 类初始化方法
 @return 类的实例对象
 */
+ (instancetype)segmentTitleConfig;

/********************* 必配项 *********************/
/** 标题数据 */
@property (nonatomic, strong) NSArray *titleArr;

/********************* 选配项 *********************/
/** 标题样式类型(默认是 指示器底部类型) */
@property (nonatomic, assign) JMSegmentTitleType titleType;
/** 标题视图背景颜色(默认白色) */
@property (nonatomic, strong) UIColor *titleBackgroundColor;
/** 标题默认颜色(默认黑色) */
@property (nonatomic, strong) UIColor *titleNorColor;
/** 标题选中颜色(默认橙色) */
@property (nonatomic, strong) UIColor *titleSelColor;
/** 默认选中标题index(默认 0) */
@property (nonatomic, assign) NSUInteger titleSelectedIndex;
/** 文字大小(默认14.f) */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题视图的高度(默认 40) 最小高度为20 */
@property (nonatomic, assign) CGFloat titleHeight;
/** 标题视图的间距(默认 20) */
@property (nonatomic, assign) CGFloat titleWidth;
/** 是否固定宽度(默认 NO) 和fixedCount配套使用 */
@property (nonatomic, assign) BOOL isFixedWidth;
/** 固定宽度的个数(默认 4个) */
@property (nonatomic, assign) NSUInteger fixedCount;

/********************* 指示器配置项 *********************/
/** 指示器颜色(默认和选中颜色相同) */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 指示器的类型(默认  */
@property (nonatomic, assign) JMSegmentIndicatorType indicatorType;


@end
