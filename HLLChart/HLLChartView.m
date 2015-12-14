//
//  HLLChartView.m
//  HLLChart
//
//  Created by admin on 15/12/10.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLChartView.h"

IB_DESIGNABLE
@interface HLLChartView ()

@property (nonatomic ,assign) CGFloat margin;
@property (nonatomic ,assign) CGFloat topHeight;
@property (nonatomic ,assign) CGFloat bottomHeight;
@property (nonatomic ,assign) CGFloat leftWidth;
@property (nonatomic ,assign) CGFloat centerBottomHeight;
@property (nonatomic ,assign) CGFloat height;
@property (nonatomic ,assign) CGFloat width;
@end

@implementation HLLChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    _width = width;
    _height = height;
//    UIBezierPath * bezier = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
//    [bezier addClip];
    
    hll_drawRect(rect);
    
    _leftWidth = 50.0f;
    _bottomHeight = 60.0f;
    _topHeight = 30.0f;
    _margin = 20.0f;

    CGRect chartNameFrame = CGRectMake(40, 10, width, _topHeight);
    hll_drawLabel(@"图表名称", NSTextAlignmentLeft, chartNameFrame,[UIColor orangeColor]);
    
    CGFloat margin_Value = (height - _topHeight - _bottomHeight) / 8.00;
    for (NSInteger index = 0; index < 8; index ++) {
        CGFloat start_x = _leftWidth;
        CGFloat start_y = height - _bottomHeight - index * margin_Value;
        CGFloat end_x = width - _margin;
        CGFloat end_y = start_y;
        hll_drawLiner(1, CGPointMake(start_x, start_y), CGPointMake(end_x, end_y));
        
        CGFloat label_width = _leftWidth;
        CGFloat label_height = margin_Value;
        CGFloat label_x = start_x - label_width - 10;
        CGFloat label_y = start_y - label_height/2;
        CGRect valueLabelFrame = CGRectMake(label_x, label_y, label_width, label_height);
        hll_drawLabel([NSString stringWithFormat:@"%ld",(long)index], NSTextAlignmentRight, valueLabelFrame, [UIColor lightGrayColor]);
    }
    
    NSArray * chartDatas = @[@2.6,@4.1,@6.7];
    
    CGFloat chartDataWidth = 40.0f;
    CGFloat chartViewWidth = width - _leftWidth - _margin;
    CGFloat chartViewHeight = height - _topHeight - _bottomHeight;
    
    CGFloat chartLabel_Width = 100.0f;
    CGFloat chartLabel_Height = 30.0f;
    
    for (NSInteger index = 0; index < chartDatas.count; index ++) {
        
        //
        CGFloat chart_width = chartDataWidth;
        CGFloat chart_height =  chartViewHeight * ([chartDatas[index] floatValue] / 8.00);
        CGFloat chart_y = height - _bottomHeight - chart_height;
        CGFloat chart_x = (index + 1) *((chartViewWidth - chartDatas.count * chart_width) / (chartDatas.count + 1)) + chart_width * index + _leftWidth;
        CGRect chartFrame = CGRectMake(chart_x, chart_y, chart_width, chart_height);
        hll_drawRect(chartFrame);
        
        //
        CGFloat chartLabel_X = CGRectGetMidX(chartFrame) - chartLabel_Width/2;
        CGFloat chartLabel_Y = CGRectGetMaxY(chartFrame);
        CGRect chartLabelFrame = CGRectMake(chartLabel_X, chartLabel_Y, chartLabel_Width, chartLabel_Height);
        hll_drawLabel(@"第一季度", NSTextAlignmentCenter, chartLabelFrame, [UIColor redColor]);
    }
    
    
    
    
}
- (void) drawChartWithDatas:(NSArray *)chartDatas{

    if (!(chartDatas && chartDatas.count)) {
        return;
    }
    
    CGFloat chartDataWidth = 40.0f;
    CGFloat chartViewWidth = _width - _leftWidth - _margin;
    CGFloat chartViewHeight = _height - _topHeight - _bottomHeight;
    
    CGFloat chartLabel_Width = 100.0f;
    CGFloat chartLabel_Height = 30.0f;
    
    for (NSInteger index = 0; index < chartDatas.count; index ++) {
        
        HLLChart * chart = chartDatas[index];
        
        //
        CGFloat chart_width = chartDataWidth;
        CGFloat chart_height =  chartViewHeight * ([chartDatas[index] floatValue] / 8.00);
        CGFloat chart_y = _height - _bottomHeight - chart_height;
        CGFloat chart_x = (index + 1) *((chartViewWidth - chartDatas.count * chart_width) / (chartDatas.count + 1)) + chart_width * index + _leftWidth;
        CGRect chartFrame = CGRectMake(chart_x, chart_y, chart_width, chart_height);
        hll_drawRect(chartFrame);
        
        //
        CGFloat chartLabel_X = CGRectGetMidX(chartFrame) - chartLabel_Width/2;
        CGFloat chartLabel_Y = CGRectGetMaxY(chartFrame);
        CGRect chartLabelFrame = CGRectMake(chartLabel_X, chartLabel_Y, chartLabel_Width, chartLabel_Height);
        hll_drawLabel(chart.chartName, NSTextAlignmentCenter, chartLabelFrame, [UIColor redColor]);
    }
    
}
void hll_drawRect(CGRect rect){

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextStrokeRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextStrokePath(context);
    CGContextSetLineWidth(context, 1.0f);
}
void hll_drawLiner(CGFloat linerWidth,CGPoint startPoint,CGPoint endPoint){

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGPoint  points[] = {
        [0] = startPoint,
        [1] = endPoint
    };
    CGContextAddLines(context, points, sizeof(points)/sizeof(startPoint));
    CGContextSetLineWidth(context, linerWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
};

void hll_drawLabel(NSString * text,NSTextAlignment alignment,CGRect frame ,UIColor * textColor){

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UILabel  * label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = alignment;
    label.textColor = textColor;
    [label drawTextInRect:frame];
    
    CGContextRestoreGState(context);
    
};

@end
