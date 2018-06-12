//
//  JMSegmentTitleConfig.m
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "JMSegmentTitleConfig.h"

@implementation JMSegmentTitleConfig

+ (instancetype)segmentTitleConfig {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        //初始化默认配置
        [self initSegmentConfig];
    }
    return self;
}

#pragma mark - 初始化默认配置
- (void)initSegmentConfig {
    _titleHeight = 20.f;
    _titleNorColor = [UIColor blackColor];
    _titleSelColor = [UIColor orangeColor];
    _indicatorColor = _titleSelColor;
    _titleSelectedIndex = 0;
    _titleFont = [UIFont systemFontOfSize:14.f];
    _indicatorType = JMSegmentIndicatorTypeDefault;
    _titleBackgroundColor = [UIColor whiteColor];
    _titleType = JMSegmentTitleTypeIndicatorBottom;
}

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
    if (titleHeight < 20) {
        _titleHeight = 20.f;
    }
}

//- (void)setTitleNorColor:(UIColor *)titleNorColor {
//    _titleNorColor = titleNorColor;
//}
//- (void)setTitleSelColor:(UIColor *)titleSelColor {
//    _titleSelColor = titleSelColor;
//}
//- (void)setIndicatorColor:(UIColor *)indicatorColor {
//    _indicatorColor = indicatorColor;
//}
//- (void)setTitleSelectedIndex:(NSUInteger *)titleSelectedIndex {
//    _titleSelectedIndex = titleSelectedIndex;
//}

@end
