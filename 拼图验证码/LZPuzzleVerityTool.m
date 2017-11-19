//
//  LZPuzzleVerityTool.m
//  拼图验证码
//
//  Created by liuzhao on 2017/11/19.
//  Copyright © 2017年 liuzhao. All rights reserved.
//

#import "LZPuzzleVerityTool.h"
#import "UIView+DrawDashLine.h"
#define RGBA(r ,g ,b ,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface LZPuzzleVerityTool ()<TTGPuzzleVerifyViewDelegate>
@property(nonatomic,strong) UIView                  *bgView;
@property(nonatomic,strong) UILabel                 *titleLabel;
@property(nonatomic,strong) UILabel                 *contentLabel;
@property(nonatomic,strong) UIView                  *contentView;

@property(nonatomic,strong) TTGPuzzleVerifyView     *verifyView;
@property(nonatomic,strong) UIView                  *slidView;
@property(nonatomic,strong) UILabel                 *slidTitle;
@property(nonatomic,strong) UIImageView             *slider;
@property(nonatomic,strong) UIActivityIndicatorView *stateView;

@property(nonatomic,strong) UIView                  *bottomLine;
@property(nonatomic,strong) UIButton                *cancelButton;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) BOOL isVeritySucess;
@end
@implementation LZPuzzleVerityTool

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        [self setLayout];
    }
    return self;
}
-(void) setupUI{
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.verifyView];
    
    [self addSubview:self.slidView];
    [self.slidView addSubview:self.slidTitle];
    [self.slidView addSubview:self.slider];
    [self.slidView addSubview:self.stateView];
    
    [self addSubview:self.bottomLine];
    [self addSubview:self.cancelButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setLayout];
}

-(void) setLayout{
    self.titleLabel.frame = CGRectMake(0, 10, self.bounds.size.width, 30);
    [UIView drawDashLine:self.titleLabel startPoint:CGPointMake(0, 25) endPoint:CGPointMake(self.bounds.size.width, 25) lineColor:RGBA(205, 205, 205, 1)];
    self.verifyView.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 11, [UIScreen mainScreen].bounds.size.width - 80, 200);
    self.slidView.frame = CGRectMake(20, CGRectGetMaxY(self.verifyView.frame) + 10, self.bounds.size.width - 40, 40);
    self.slidTitle.frame = CGRectMake(0, 0, self.bounds.size.width , 40);
    self.slider.frame = CGRectMake(2, 2, 72, 36);
    self.stateView.frame = CGRectMake(0, 0, 40, 40);
    self.stateView.center = self.slidView.center;
    self.bottomLine.frame = CGRectMake(0, CGRectGetMaxY(self.slidView.frame) + 15, self.bounds.size.width, 0.5);
    self.cancelButton.frame = CGRectMake(0, CGRectGetMaxY(self.bottomLine.frame), self.bounds.size.width, 35);
    
}
-(UIView *)bottomLine{
    
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = RGBA(167, 167, 168, 1);
    }
    return _bottomLine;
}

-(UIButton *)cancelButton{
    
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:RGBA(146, 146, 146, 1) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = RGBA(50, 50, 50, 1);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = RGBA(102, 102, 102, 1);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(TTGPuzzleVerifyView *)verifyView{
    
    if (_verifyView == nil) {
        _verifyView = [[TTGPuzzleVerifyView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 11, [UIScreen mainScreen].bounds.size.width - 80, 200)];
        _verifyView.image = [UIImage imageNamed:@"pic3"];
        _verifyView.puzzleBlankPosition = CGPointMake(150, 40);
        _verifyView.puzzlePosition = CGPointMake(10, 40);
        _verifyView.puzzleXPercentage = 0.1;
        _verifyView.puzzleSize = CGSizeMake(40, 40);
        _verifyView.layer.cornerRadius = 10;
        _verifyView.layer.masksToBounds = YES;
        _verifyView.delegate = self;
    }
    return _verifyView;
}

-(UIView *)slidView{
    
    if (_slidView == nil) {
        _slidView = [[UIView alloc] init];
        _slidView.backgroundColor = RGBA(228, 247, 220, 1);
        _slidView.layer.cornerRadius = 20;
        _slidView.layer.masksToBounds = YES;
        _slidView.layer.borderWidth = 1;
        _slidView.layer.borderColor = RGBA(226, 224, 224, 1).CGColor;
    }
    return _slidView;
}

-(UILabel *)slidTitle{
    
    if (_slidTitle == nil) {
        _slidTitle = [[UILabel alloc] init];
        _slidTitle.textColor = RGBA(119, 119, 119, 1);
        _slidTitle.font = [UIFont systemFontOfSize:13];
        _slidTitle.textAlignment = NSTextAlignmentCenter;
        _slidTitle.text = @">>>请拖动滑块完成拼图>>>";
    }
    return _slidTitle;
}

-(UIImageView *)slider{
    
    if (_slider == nil) {
        _slider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_icon"]];
        _slider.userInteractionEnabled = YES;
        [self addPanGestureTecognizer];
    }
    return _slider;
}
//创建平移手势
-(void) addPanGestureTecognizer
{
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    //添加到指定视图
    [_slider addGestureRecognizer:pan];
}
-(UIView *)bgView{
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _bgView.backgroundColor = RGBA(0, 0, 0, 0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
-(void) hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void) showVieWithTitle:(NSString *)title {
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    
    self.titleLabel.text = title;
   
    
    [superView addSubview:self.bgView];
    [superView addSubview:self];
    
    self.alpha = 0;
    self.frame = CGRectMake(20, ([UIScreen mainScreen].bounds.size.height - 360)/2, [UIScreen mainScreen].bounds.size.width - 40 , 360);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {}];
}
//拖动事件
-(void)panAction:(UIPanGestureRecognizer *)panGestureRecognizer
{
    //视图前置操作
    [panGestureRecognizer.view.superview bringSubviewToFront:panGestureRecognizer.view];
    
    CGPoint center = panGestureRecognizer.view.center;
    CGPoint translation = [panGestureRecognizer translationInView:self.slider];
    if (center.x < 40) {
        center.x = 40;
    }
    if (center.x > ([UIScreen mainScreen].bounds.size.width - 80 - 40)) {
        center.x = [UIScreen mainScreen].bounds.size.width - 80 - 40;
    }
    panGestureRecognizer.view.center = CGPointMake(center.x + translation.x, center.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:self.slider];
    CGFloat value = (center.x - 40)/([UIScreen mainScreen].bounds.size.width - 80-40 -40);
    NSLog(@" value == %f" ,value);
    _verifyView.puzzleXPercentage = value;
   
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded || panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        
        if (self.isVeritySucess) {
            
            [_verifyView completeVerificationWithAnimation:YES];
        }
        _verifyView.enable = NO;
        _slider.hidden = YES;
        _slidTitle.text = @"";
        [_stateView startAnimating];
        [self performSelector:@selector(verify) withObject:self afterDelay:1.0];
        
        
    }
    
}

-(void) verify{
    
    [_stateView stopAnimating];
    self.slidTitle.frame = CGRectMake(0, 0, self.bounds.size.width, 40);
    BOOL isSuc = NO;
    if (self.isVeritySucess) {
        _slidTitle.text = @"验证成功";
        isSuc = YES;
        NSLog(@"success");
    }else{
        isSuc = NO;
        NSLog(@"fail");
        _slidTitle.text = @"验证失败";
        
    }
    if ([self.delegate respondsToSelector:@selector(puzzleVerifyViewVerifyIsSuc:)]) {
        [self.delegate puzzleVerifyViewVerifyIsSuc:isSuc];
    }
    
    [self performSelector:@selector(popView) withObject:self afterDelay:1.5];
}

-(void) popView{
    
    
    [self hide];
    
    
}
- (void)puzzleVerifyView:(TTGPuzzleVerifyView *)puzzleVerifyView didChangedPuzzlePosition:(CGPoint)newPosition
             xPercentage:(CGFloat)xPercentage yPercentage:(CGFloat)yPercentage{
//    NSLog(@"newPosition %@ xPercentage=%f yPercentage=%f" ,NSStringFromCGPoint(newPosition) ,xPercentage ,yPercentage);
}

- (void)puzzleVerifyView:(TTGPuzzleVerifyView *)puzzleVerifyView didChangedVerification:(BOOL)isVerified{
    self.isVeritySucess = isVerified;
    NSLog(@"isVerified = %d" ,isVerified);
    
}
@end
