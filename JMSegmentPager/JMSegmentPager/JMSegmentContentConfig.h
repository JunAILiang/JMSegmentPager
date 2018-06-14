//
//  JMSegmentContentConfig.h
//  JMSegmentPager
//
//  Created by JM on 2018/6/13.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSegmentContentConfig : NSObject

+ (instancetype)segmentContentConfig;

/********************* 必配项 *********************/
/** 控制器数组 */
@property (nonatomic, strong) NSArray *controllerArr;

@end
