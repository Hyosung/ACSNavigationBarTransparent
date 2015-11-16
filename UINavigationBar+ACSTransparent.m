//
//  UINavigationBar+ACSTransparent.m
//  PolyLove_Pregnancy
//
//  Created by 上海易凡 on 15/11/16.
//  Copyright © 2015年 Stone.y. All rights reserved.
//

#import "UINavigationBar+ACSTransparent.h"

#import <objc/runtime.h>

@implementation UINavigationBar (ACSTransparent)

#pragma mark - Private Methods

- (UIView *)acs_navigationBarBackgroundView {
    UIView *backgroundView = objc_getAssociatedObject(self, @selector(acs_navigationBarBackgroundView));
    if (!backgroundView) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                backgroundView = subView;
                objc_setAssociatedObject(self, @selector(acs_navigationBarBackgroundView), subView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                break;
            }
        }
    }
    return backgroundView;
}

- (UIImage *)transparentImageWithSize:(CGSize) size {
    static UIImage *transparentImage = nil;
    static dispatch_once_t onceToken;
    size = CGSizeMake(size.width, 64.0);
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [[UIColor clearColor] set];
        transparentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return transparentImage;
}

#pragma mark - Getter And Setter

- (void)setNavigationTransparent:(BOOL)transparent animated:(BOOL)animated {
    objc_setAssociatedObject(self, @selector(setNavigationTransparent:), @(transparent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.transparentType == ACSTransparentTypeDefault) {
        if (transparent) {
            UIImage *transparentImage = [self transparentImageWithSize:self.frame.size];
            [self setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
            self.shadowImage = transparentImage;
        }
        else {
            [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            self.shadowImage = [UIImage new];
        }
    }
    else {
        if (animated) {
            
            [UIView animateWithDuration:0.28 animations:^{
                [self acs_navigationBarBackgroundView].alpha = transparent ? 0.0 : 1.0;
            }];
        }
        else {
            [self acs_navigationBarBackgroundView].hidden = transparent;
        }
    }
}

- (void)setNavigationTransparent:(BOOL)navigationTransparent {
    [self setNavigationTransparent:navigationTransparent animated:NO];
}

- (BOOL)isNavigationTransparent {
    return [objc_getAssociatedObject(self, @selector(setNavigationTransparent:)) boolValue];
}

- (void)setTransparentType:(ACSTransparentType)transparentType {
    
    objc_setAssociatedObject(self, @selector(setTransparentType:), @(transparentType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ACSTransparentType)transparentType {
    
    return [objc_getAssociatedObject(self, @selector(setTransparentType:)) unsignedIntegerValue];
}

@end
