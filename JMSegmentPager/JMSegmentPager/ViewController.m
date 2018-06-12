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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    JMSegmentTitleConfig *titleConfig = [JMSegmentTitleConfig segmentTitleConfig];
    titleConfig.titleArr = @[@"首页",@"发现",@"首页",@"发现",@"首页",@"发现",@"首页",@"发现"];
    titleConfig.titleHeight = 34.f;
    titleConfig.indicatorType = JMSegmentIndicatorTypeEqualTitle;
    titleConfig.titleSelectedIndex = 6;
    //    titleConfig.titleAlpha = 0.1f;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [view addGestureRecognizer:tap];
    
    JMSegmentPager *segmentPage = [[JMSegmentPager alloc] initWithSegmentPagerWithTitleConfig:titleConfig];
    [segmentPage addCustomView:view AtIndex:7];
    [self.view addSubview:segmentPage];
    
    
    
    [segmentPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
}

#pragma mark - 按钮点击事件
- (void)tapClick {
    NSLog(@"点击了");
}


@end
