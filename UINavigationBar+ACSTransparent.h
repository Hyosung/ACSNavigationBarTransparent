//
//  UINavigationBar+ACSTransparent.h
//  PolyLove_Pregnancy
//
//  Created by 上海易凡 on 15/11/16.
//  Copyright © 2015年 Stone.y. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 透明的类型
 */
typedef NS_ENUM(NSUInteger, ACSTransparentType) {
    /**
     默认 透明背景
     */
    ACSTransparentTypeDefault = 0,
    /**
     隐藏背景视图
     */
    ACSTransparentTypeHideBackground,
};

@interface UINavigationBar (ACSTransparent)

@property (nonatomic) ACSTransparentType transparentType; // default ACSTransparentTypeDefault
@property(nonatomic,getter=isNavigationTransparent) BOOL navigationTransparent;
- (void)setNavigationTransparent:(BOOL)transparent animated:(BOOL)animated; // ACSTransparentTypeHideBackground 才有动画

@end
