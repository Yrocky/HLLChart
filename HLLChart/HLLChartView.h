//
//  HLLChartView.h
//  HLLChart
//
//  Created by admin on 15/12/10.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString * (^blockValue)(NSInteger item);
typedef UIColor * (^blockColor)(NSInteger item);

@interface HLLChartView : UIView


@property (nonatomic ,assign) NSInteger valueCount;
@property (nonatomic ,assign) blockValue valueText;
@property (nonatomic ,assign) NSInteger valueStep;


@property (nonatomic ,assign) NSInteger keyCount;
@property (nonatomic ,assign) blockValue keyText;

@property (nonatomic ,assign) NSInteger datasCount;

@end

@interface HLLChart : NSObject

@property (nonatomic ,assign) CGFloat maxChart;

@property (nonatomic ,strong) NSString * chartName;
@property (nonatomic ,strong) NSArray * chartDatas;
@property (nonatomic ,assign) blockColor chartColor;

- (void) drawChartWithDatas:(NSArray *)datas;
@end