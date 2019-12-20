//
//  GTBatteryView.h
//  CustomView
//
//  Created by 123 on 2019/12/19.
//  Copyright © 2019 123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GTBatteryViewTextFormatter <NSObject>
@required
-(NSString *)stringForValue:(CGFloat)value;
@end

@interface GTBatteryView : UIView
@property (assign,nonatomic) IBInspectable CGFloat shellWidth; //电池壳宽度
@property (assign,nonatomic) IBInspectable CGFloat shellCornerRadius; //电池壳圆角
@property (assign,nonatomic) IBInspectable CGFloat shellHeight; //电池壳高度
@property (assign,nonatomic) IBInspectable CGFloat shellStrokeWidth; //电池壳厚度
@property (assign,nonatomic) IBInspectable CGFloat gap;//电池外壳和电池等级直接的间距

@property (assign,nonatomic) IBInspectable CGFloat shellHeadWidth; //电池头宽度
@property (assign,nonatomic) IBInspectable CGFloat shellHeadHeight; //电池头高度
@property (assign,nonatomic) IBInspectable CGFloat shellHeadCornerRadius; //电池头圆角度

@property (strong, nonatomic) IBInspectable UIColor *lowerPowerColor;
@property (strong, nonatomic) IBInspectable UIColor *middlePowerColor;
@property (strong, nonatomic) IBInspectable UIColor *highPowerColor;

@property (assign, nonatomic) IBInspectable CGFloat textSize;
@property (assign, nonatomic) IBInspectable CGFloat textHeight;
@property (assign, nonatomic) IBInspectable CGFloat textMarginTop;
@property (strong, nonatomic) IBInspectable UIColor *textColor;
@property (assign,nonatomic) IBInspectable BOOL textAutoAdjustFontSize;

@property (assign, nonatomic) IBInspectable CGFloat max;
@property (assign, nonatomic) IBInspectable CGFloat min;
@property (assign, nonatomic) IBInspectable CGFloat leve;
@property (weak,nonatomic) id<GTBatteryViewTextFormatter> delegate;
@end

NS_ASSUME_NONNULL_END
