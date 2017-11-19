//
//  ViewController.m
//  拼图验证码
//
//  Created by liuzhao on 2017/11/19.
//  Copyright © 2017年 liuzhao. All rights reserved.
//

#import "ViewController.h"
#import "TTGPuzzleVerifyView.h"
#import "UIView+DrawDashLine.h"
#import "LZPuzzleVerityTool.h"
@interface ViewController ()<TTGPuzzleVerifyViewDelegate ,LZPuzzleVerityToolDelegate>
@property (strong, nonatomic)  TTGPuzzleVerifyView *puzzleVerifyView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)accc:(id)sender {
//    self.puzzleVerifyView = [[TTGPuzzleVerifyView alloc] initWithFrame:CGRectMake(50, 100, 300, 250)];
//    [self.view addSubview:_puzzleVerifyView];
//    _puzzleVerifyView.image = [UIImage imageNamed:@"pic3"];
//    _puzzleVerifyView.puzzleBlankPosition = CGPointMake(100, 40);
//    _puzzleVerifyView.puzzlePosition = CGPointMake(10, 40);
//    _puzzleVerifyView.puzzleXPercentage = 0.1;
//    _puzzleVerifyView.puzzleSize =  CGSizeMake(40, 40);
//    _puzzleVerifyView.delegate = self;
    
    LZPuzzleVerityTool *too = [[LZPuzzleVerityTool alloc] init];
    [too showVieWithTitle:@"登陆验证"];
    
}
- (IBAction)slider:(UISlider *)sender {
    _puzzleVerifyView.puzzleXPercentage = sender.value;
}
//- (void)puzzleVerifyView:(TTGPuzzleVerifyView *)puzzleVerifyView didChangedPuzzlePosition:(CGPoint)newPosition
//             xPercentage:(CGFloat)xPercentage yPercentage:(CGFloat)yPercentage{
//    NSLog(@"newPosition %@ xPercentage=%f yPercentage=%f" ,NSStringFromCGPoint(newPosition) ,xPercentage ,yPercentage);
//}

//- (void)puzzleVerifyView:(TTGPuzzleVerifyView *)puzzleVerifyView didChangedVerification:(BOOL)isVerified{
//    NSLog(@"isVerified = %d" ,isVerified);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
