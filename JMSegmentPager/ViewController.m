//
//  ViewController.m
//  JMScrollContentView
//
//  Created by JM on 2018/6/11.
//  Copyright © 2018年 JM. All rights reserved.
//

#import "ViewController.h"
#import "JMSegmentPager.h"
#import "Masonry.h"

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface ViewController ()<JMSegmentPagerDelegate>

/** segmentPage */
@property (nonatomic, strong) JMSegmentPager *segmentPager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    JMSegmentTitleConfig *titleConfig = [JMSegmentTitleConfig segmentTitleConfig];
    titleConfig.titleArr = @[@"首页",@"发现",@"首页",@"发现",@"首页",@"发现",@"首页",@"发现"];
    titleConfig.titleHeight = 34.f;
    titleConfig.indicatorType = JMSegmentIndicatorTypeEqualTitle;
    titleConfig.isFixedWidth = YES;
    titleConfig.titleSelectedIndex = 3;
    //    titleConfig.titleAlpha = 0.1f;
    
    JMSegmentContentConfig *contentConfig = [JMSegmentContentConfig segmentContentConfig];
    NSMutableArray *tempArrM = [NSMutableArray array];
    for (int i = 0; i < titleConfig.titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = kRandomColor;
        [tempArrM addObject:vc];
    }
    contentConfig.controllerArr = tempArrM;
    
    
    self.segmentPager = [[JMSegmentPager alloc] initWithSegmentPagerWithTitleConfig:titleConfig ContentConfig:contentConfig Delegate:self];;
    [self.view addSubview:self.segmentPager];
    
    [self.segmentPager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
}

- (void)JMSegmentPagerTitle:(NSString *)title Index:(NSInteger)index {
    NSLog(@"title--%@,  index---%zd",title, index);
}

#pragma mark - 按钮点击事件
- (void)tapClick {
    NSLog(@"点击了");
    self.segmentPager.titleSelectIndex = 3;
}


@end
