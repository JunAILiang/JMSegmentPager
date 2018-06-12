//
//  JMSegmentPager.m
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "JMSegmentPager.h"

@interface JMSegmentPager()

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) JMSegmentTitleConfig *titleConfig;
@property (nonatomic, strong) NSMutableArray *btnArrM;
@property (nonatomic, strong) UIImageView *indicatorIV;
@property (nonatomic, assign) NSInteger titleSelectIndex;

@end

@implementation JMSegmentPager

- (NSMutableArray *)btnArrM {
    if (!_btnArrM) {
        _btnArrM = [NSMutableArray array];
    }
    return _btnArrM;
}

- (UIImageView *)indicatorIV {
    if (!_indicatorIV) {
        _indicatorIV = [[UIImageView alloc] init];
        _indicatorIV.backgroundColor = self.titleConfig.indicatorColor;
        [self.titleScrollView addSubview:_indicatorIV];
    }
    return _indicatorIV;
}

- (instancetype)initWithSegmentPagerWithTitleConfig:(JMSegmentTitleConfig *)titleConfig {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.titleConfig = titleConfig;
        
        //给index赋值
        self.titleSelectIndex = self.titleConfig.titleSelectedIndex;
        
        //初始化UI
        [self initSegmentPagerUI];
    }
    return self;
}

#pragma mark - 初始化UI
- (void)initSegmentPagerUI {
    //标题滚动视图
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = self.titleConfig.titleBackgroundColor;
    [self addSubview:self.titleScrollView];

    //标题数组
    [self.titleConfig.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:self.titleConfig.titleNorColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleConfig.titleSelColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.titleConfig.titleFont;
        btn.tag = idx;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        
        [self.btnArrM addObject:btn];
    }];


}

- (void)setTitleSelectIndex:(NSInteger)titleSelectIndex {
    _titleSelectIndex = titleSelectIndex;
    
    NSLog(@"%zd",titleSelectIndex);
    
    if (self.btnArrM.count <= 0) {
        return;
    }
    
    for (UIButton *btn in self.btnArrM) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
    }
    
    
    UIButton *lastBtn = self.btnArrM[titleSelectIndex];
    lastBtn.selected = YES;
    
    [self moveIndicatorIV:YES];
}

#pragma mark - 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    if (btn.tag == self.titleSelectIndex) {
        return;
    }

    self.titleSelectIndex = btn.tag;
}

#pragma mark - 移动指示器
- (void)moveIndicatorIV:(BOOL)animated {
    UIButton *selectBtn = self.btnArrM[self.titleSelectIndex];
    [UIView animateWithDuration:(animated ? 0.3 : 0) animations:^{
        CGFloat indicatorX = 0;
        CGFloat indicatorY = selectBtn.frame.size.height - 2;
        CGFloat indicatorW = 0;
        CGFloat indicatorH = 2;
        if (self.titleConfig.indicatorType == JMSegmentIndicatorTypeDefault) {
            indicatorX = selectBtn.frame.origin.x;
            indicatorW = selectBtn.frame.size.width;
        } else if (self.titleConfig.indicatorType == JMSegmentIndicatorTypeEqualTitle) {
            indicatorW = [self getWidthWithString:selectBtn.titleLabel.text font:selectBtn.titleLabel.font];
            indicatorX = selectBtn.frame.origin.x + (selectBtn.frame.size.width * 0.5 - indicatorW * 0.5);
        }
        self.indicatorIV.frame = CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.titleScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.titleConfig.titleHeight);
    
    [self.btnArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = obj;
        
        CGFloat btnY = 0;
        CGFloat btnW = self.titleScrollView.frame.size.width / self.btnArrM.count;
        CGFloat btnx = idx * btnW;
        CGFloat btnH = self.titleScrollView.frame.size.height;
        
        if (idx == self.titleSelectIndex) {
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.selected = YES;
            }

            [self moveIndicatorIV:YES];
        }

        btn.frame = CGRectMake(btnx, btnY, btnW, btnH);
        
    }];
}

- (void)addCustomView:(UIView *)customView AtIndex:(NSInteger)atIndex {
    if (atIndex >= self.btnArrM.count) {
        NSLog(@"数组将越界, 取消插入");
        return;
    } else if ([customView isKindOfClass:[UIButton class]]) {
        NSLog(@"不能插入UIButton控件, 取消插入");
        return;
    }
    
    UIButton *btn = self.btnArrM[atIndex];
    [btn removeFromSuperview];
    [self.titleScrollView addSubview:customView];
    
    [self.btnArrM removeObjectAtIndex:atIndex];

    [self.btnArrM insertObject:customView atIndex:atIndex];
}


#pragma mark - 获取文字的宽度
- (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

@end
