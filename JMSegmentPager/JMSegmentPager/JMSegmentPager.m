//
//  JMSegmentPager.m
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "JMSegmentPager.h"

@interface JMSegmentPager()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) JMSegmentTitleConfig *titleConfig;
@property (nonatomic, strong) JMSegmentContentConfig *contentConfig;
@property (nonatomic, strong) NSMutableArray *btnArrM;
@property (nonatomic, strong) NSMutableArray *controllerArrM;
@property (nonatomic, strong) UIImageView *indicatorIV;

@end

@implementation JMSegmentPager

- (NSMutableArray *)controllerArrM {
    if (!_controllerArrM) {
        _controllerArrM = [NSMutableArray array];
    }
    return _controllerArrM;
}

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


- (instancetype)initWithSegmentPagerWithTitleConfig:(JMSegmentTitleConfig *)titleConfig ContentConfig:(JMSegmentContentConfig *)contentConfig Delegate:(id<JMSegmentPagerDelegate>)delegate{
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.titleConfig = titleConfig;
        self.contentConfig = contentConfig;
        self.delegate = delegate;
        
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
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.bounces = NO;
    [self addSubview:self.titleScrollView];
    
    //标题数组
    [self.titleConfig.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMSegmentButton *btn = [JMSegmentButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:self.titleConfig.titleNorColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleConfig.titleSelColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.titleConfig.titleFont;
        btn.tag = idx;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        
        [self.btnArrM addObject:btn];
    }];

    //控制器数组
    if (self.contentConfig.controllerArr.count > 0) { //防止没有控制器数组时往页面上添加视图, 优化性能
        //内容滚动视图
        self.contentScrollView = [[UIScrollView alloc] init];
        self.contentScrollView.bounces = NO;
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.showsVerticalScrollIndicator = NO;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.delegate = self;
        [self addSubview:self.contentScrollView];
    }
    [self.contentConfig.controllerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = obj;
        if (![vc isKindOfClass:[UIViewController class]]) {
            NSLog(@"不是控制器类型,无法完成初始化");
            return;
        } else if (self.titleConfig.titleArr.count != self.contentConfig.controllerArr.count) {
            NSLog(@"标题数组和控制器数组不一致, 无法完成初始化");
            return;
        }
        
        [self.contentScrollView addSubview:vc.view];
        [self.controllerArrM addObject:vc.view];
        
    }];

}

- (void)setTitleSelectIndex:(NSInteger)titleSelectIndex {
    _titleSelectIndex = titleSelectIndex;
    
    if (self.btnArrM.count <= 0) {
        return;
    }
    
    for (JMSegmentButton *btn in self.btnArrM) {
        if ([btn isMemberOfClass:[JMSegmentButton class]]) {
            btn.selected = NO;
        }
    }
    
    JMSegmentButton *lastBtn = self.btnArrM[titleSelectIndex];
    lastBtn.selected = YES;
    
    [self moveIndicatorIV:YES];
}

#pragma mark - 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    if (btn.tag == self.titleSelectIndex) {
        return;
    }
    
    self.titleSelectIndex = btn.tag;
    
    if ([self.delegate respondsToSelector:@selector(JMSegmentPagerTitle:Index:)]) {
        [self.delegate JMSegmentPagerTitle:btn.titleLabel.text Index:btn.tag];
    }
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
    
    CGFloat offsetX = selectBtn.center.x - self.titleScrollView.frame.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width) {
        offsetX = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    }
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    [self.contentScrollView setContentOffset:CGPointMake(self.titleSelectIndex * self.contentScrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    
    //设置内容滚动视图和标题滚动视图
    self.contentScrollView.contentSize = CGSizeMake(width * self.contentConfig.controllerArr.count, 0);
    
    self.titleScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.titleConfig.titleHeight);
    self.contentScrollView.frame = CGRectMake(0, self.titleConfig.titleHeight, self.frame.size.width, self.frame.size.height - self.titleConfig.titleHeight);
    
    [self.btnArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JMSegmentButton *btn = obj;
        CGFloat btnY = 0;
        CGFloat btnW = 0.f;
        if (self.titleConfig.isFixedWidth) {
            btnW = self.titleScrollView.frame.size.width / self.titleConfig.fixedCount;
        } else {
            btnW = self.titleConfig.titleWidth + [self getWidthWithString:btn.titleLabel.text font:btn.titleLabel.font];
        }
        CGFloat btnx = idx * btnW;
        CGFloat btnH = self.titleScrollView.frame.size.height;
        
        if (idx == self.titleSelectIndex) {
            if ([btn isMemberOfClass:[JMSegmentButton class]]) {
                btn.selected = YES;
            }

            [self moveIndicatorIV:YES];
        }

        btn.frame = CGRectMake(btnx, btnY, btnW, btnH);
        
        if (idx == self.btnArrM.count-1) { //最后一个
            self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
        }
    }];

    
    [self.controllerArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        
        CGFloat viewH = self.contentScrollView.frame.size.height;
        CGFloat viewY = 0;
        CGFloat viewW = self.contentScrollView.frame.size.width;
        CGFloat viewX = idx * viewW;
        
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }];
    
}

- (void)addCustomView:(UIView *)customView AtIndex:(NSInteger)atIndex {
    if (atIndex >= self.btnArrM.count) {
        [self.btnArrM addObject:customView];
    } else {
        JMSegmentButton *btn = self.btnArrM[atIndex];
        [btn removeFromSuperview];
        [self.btnArrM removeObjectAtIndex:atIndex];
        [self.btnArrM insertObject:customView atIndex:atIndex];
    }
    [self.titleScrollView addSubview:customView];
}


#pragma mark - 获取文字的宽度
- (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

#pragma mark - UIScrollViewDelegate
#pragma mark - 当滚动scrollView时
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"当滚动scrollView时%@",NSStringFromCGPoint(scrollView.contentOffset));
//    CGFloat scale = scrollView.contentOffset.x/scrollView.contentSize.width;
//    NSLog(@"当滚动scrollView时%f",scrollView.contentOffset.x);
//    NSLog(@"当滚动scrollView时%f",scrollView.contentSize.width);
//    NSLog(@"当滚动scrollView时%f",scale);
//}

//#pragma mark - 即将拖拽的时候调用
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"即将拖拽的时候%@",NSStringFromCGPoint(scrollView.contentOffset));
//}
//
//#pragma mark - 停止拖拽的时候调用
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"停止拖拽的时候调用%@",NSStringFromCGPoint(scrollView.contentOffset));
//}

#pragma mark - 滚动完毕时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.titleSelectIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
}

@end




@implementation JMSegmentButton

@end
