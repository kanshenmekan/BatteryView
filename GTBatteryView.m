//
//  GTBatteryView.m
//  CustomView
//
//  Created by 123 on 2019/12/19.
//  Copyright © 2019 123. All rights reserved.
//

#import "GTBatteryView.h"
@interface GTBatteryView()
@property (strong, nonatomic) CAShapeLayer *shellLayer;
@property (strong, nonatomic) CAShapeLayer *shellHeadLayer;
@property (strong, nonatomic) CAShapeLayer *leveLayer;
@property (strong, nonatomic) UILabel *textLabel;
@end

IB_DESIGNABLE
@implementation GTBatteryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) [self commonInit];
    return self;
}
- (void)commonInit {
    // Default values
    _lowerPowerColor = [UIColor redColor];
    _middlePowerColor = [UIColor blueColor];
    _highPowerColor = [UIColor greenColor];
    _shellWidth = 20;
    _shellHeight = 34;
    _shellCornerRadius = 3;
    _shellStrokeWidth = 2;
    
    _shellHeadHeight = 3;
    _shellHeadWidth = 10;
    _shellHeadCornerRadius = 2;
    
    _gap = 2;
    _textSize = 14;
    _textColor = [UIColor blackColor];
    _textHeight = 20;
    _textMarginTop = 2;
    _max = 100;
    _min = 0;
    _leve = 0;
    _textAutoAdjustFontSize = NO;
    [self.layer addSublayer:self.shellHeadLayer];
    [self.layer addSublayer:self.shellLayer];
    [self.layer addSublayer:self.leveLayer];
    [self addSubview:self.textLabel];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    [self initViewPosition:self.frame.size];
    [self invalidateIntrinsicContentSize];
    
}
-(void)initViewPosition:(CGSize)size{
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat centerX = width/2;
    CGFloat centerY = height/2;
    CGFloat batteryHeight = self.shellHeight + self.shellStrokeWidth + self.shellHeadHeight + self.textHeight + self.textMarginTop;
    CGFloat headY = centerY - batteryHeight/2;
    CGFloat headX = centerX - self.shellHeadWidth / 2;
    self.shellHeadLayer.frame = CGRectMake(headX, headY, _shellHeadWidth, _shellHeadHeight);
    UIBezierPath *headPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _shellHeadWidth, _shellHeadHeight) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(_shellHeadCornerRadius, _shellHeadCornerRadius)];
    self.shellHeadLayer.path = headPath.CGPath;
    
    CGFloat shellX = centerX - self.shellWidth/2;
    CGFloat shellY = headY + self.shellHeadHeight;
    self.shellLayer.frame = CGRectMake(shellX, shellY, _shellWidth, _shellHeight);
    UIBezierPath *shellPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_shellStrokeWidth/2, _shellStrokeWidth/2 ,_shellWidth - _shellStrokeWidth, _shellHeight- _shellStrokeWidth) cornerRadius:_shellCornerRadius];
    self.shellLayer.lineWidth = _shellStrokeWidth;
    self.shellLayer.path = shellPath.CGPath;
    
    CGFloat leveX = shellX +_shellStrokeWidth+_gap;
    CGFloat leveY = shellY +_shellStrokeWidth+_gap;
    self.leveLayer.frame = CGRectMake(leveX, leveY, _shellWidth - _shellStrokeWidth*2 - _gap*2, _shellHeight- _shellStrokeWidth*2 - _gap*2);
    self.leve = _leve;
    self.textLabel.frame = CGRectMake(0, shellY+_shellHeight+_textMarginTop, width, _textHeight);
    NSLog(@"initViewPosition");
}
- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc]init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = _textColor;
        _textLabel.font = [UIFont systemFontOfSize:_textSize];
        if(self.delegate!=nil){
            _textLabel.text = [self.delegate stringForValue:_leve];
        }else{
            _textLabel.text = [NSString stringWithFormat:@"%.2f",_leve];
        }
        _textLabel.adjustsFontSizeToFitWidth = _textAutoAdjustFontSize;
    }
    return _textLabel;
}
-(void)setTextSize:(CGFloat)textSize{
    _textSize = textSize;
    self.textLabel.font = [UIFont systemFontOfSize:_textSize];
    [self invalidateIntrinsicContentSize];
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textLabel.textColor = _textColor;
}
-(void)setTextAutoAdjustFontSize:(BOOL)textAutoAdjustFontSize{
    _textAutoAdjustFontSize = textAutoAdjustFontSize;
    self.textLabel.adjustsFontSizeToFitWidth = textAutoAdjustFontSize;
}
- (CAShapeLayer *)shellHeadLayer{
    if(!_shellHeadLayer){
        _shellHeadLayer = [CAShapeLayer layer];
        _shellHeadLayer.contentsScale = [UIScreen mainScreen].scale;
        _shellHeadLayer.fillColor = _lowerPowerColor.CGColor;
        _shellHeadLayer.lineCap = kCALineCapRound;
        _shellHeadLayer.lineWidth = 0;
    }
    return _shellHeadLayer;
}
- (CAShapeLayer *)shellLayer{
    if(!_shellLayer){
        _shellLayer = [CAShapeLayer layer];
        _shellLayer.contentsScale = [UIScreen mainScreen].scale;
        _shellLayer.fillColor = [UIColor clearColor].CGColor;
        _shellLayer.lineCap = kCALineCapRound;
        _shellLayer.strokeColor = _lowerPowerColor.CGColor;
        _shellLayer.lineWidth = _shellStrokeWidth;
    }
    return _shellLayer;
}
-(CAShapeLayer *)leveLayer{
    if(!_leveLayer){
        _leveLayer = [CAShapeLayer layer];
        _leveLayer.contentsScale = [UIScreen mainScreen].scale;
        _leveLayer.fillColor = _lowerPowerColor.CGColor;
        _leveLayer.lineWidth = 0;
    }
    return _leveLayer;
}
- (void)setLeve:(CGFloat)leve{
    if (leve < _min) {
        leve = _min;
    }else if(leve>_max){
        leve = _max;
    }
    _leve = leve;
    CGFloat precent = (leve - _min)/(_max - _min);
    if(precent <0.1){
        _shellLayer.strokeColor = _lowerPowerColor.CGColor;
        _shellHeadLayer.fillColor = _lowerPowerColor.CGColor;
        _leveLayer.fillColor = _lowerPowerColor.CGColor;
    }else if(precent > 0.3){
        _shellLayer.strokeColor = _highPowerColor.CGColor;
        _shellHeadLayer.fillColor = _highPowerColor.CGColor;
        _leveLayer.fillColor = _highPowerColor.CGColor;
    }else {
        _shellLayer.strokeColor = _middlePowerColor.CGColor;
        _shellHeadLayer.fillColor = _middlePowerColor.CGColor;
        _leveLayer.fillColor = _middlePowerColor.CGColor;
    }
    if(self.delegate!=nil){
        _textLabel.text = [self.delegate stringForValue:_leve];
    }else{
        _textLabel.text = [NSString stringWithFormat:@"%.2f",_leve];
    }
    
    CGFloat leveHeight = self.leveLayer.bounds.size.height;
    CGFloat leveWidth = self.leveLayer.bounds.size.width;
    UIBezierPath *levePath = [UIBezierPath bezierPathWithRect:CGRectMake(0,leveHeight*(1-precent) ,leveWidth,leveHeight*precent)];
    self.leveLayer.path = levePath.CGPath;
}
- (void)setMin:(CGFloat)min{
    _min = min;
    if (_leve < min) {
        _leve = min;
    }
}
-(void)setMax:(CGFloat)max{
    _max = max;
    if(_leve > max){
        _leve = max;
    }
    [self invalidateIntrinsicContentSize];
}
- (void)setDelegate:(id<GTBatteryViewTextFormatter>)delegate{
    _delegate = delegate;
    [self invalidateIntrinsicContentSize];
}
- (CGSize)intrinsicContentSize{
    NSString *text;
    if(self.delegate==nil){
        text = [NSString stringWithFormat:@"%.2f",_max*10];
    }else{
        text = [self.delegate stringForValue:_max*10];
    }
    CGFloat width = self.shellWidth > [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize]}].width?self.shellWidth: [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.textSize]}].width;
    CGFloat height = self.shellHeadHeight + self.shellHeight + self.textMarginTop +self.textHeight;
    return CGSizeMake(width, height);
}
@end
