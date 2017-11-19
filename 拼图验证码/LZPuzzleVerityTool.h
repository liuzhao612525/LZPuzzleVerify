//
//  LZPuzzleVerityTool.h
//  拼图验证码
//
//  Created by liuzhao on 2017/11/19.
//  Copyright © 2017年 liuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGPuzzleVerifyView.h"

@class LZPuzzleVerityTool;
@protocol LZPuzzleVerityToolDelegate <NSObject>

@optional
-(void) puzzleVerifyViewVerifyIsSuc:(BOOL)isSuc;

@end

@interface LZPuzzleVerityTool : UIView
//事响应
@property (nonatomic,assign) id<LZPuzzleVerityToolDelegate>    delegate;
-(void) showVieWithTitle:(NSString *)title;
@end
