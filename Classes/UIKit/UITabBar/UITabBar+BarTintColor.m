//
//  UITabBar+BarTintColor.m
//  UITabBar+BarTintColor
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UITabBar+BarTintColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UITabBar ()

@property (nonatomic, strong) UIColor *normalBarTintColor;

@end

static char *nightBarTintColorKey;
static char *normalBarTintColorKey;

@implementation UITabBar (BarTintColor)

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setBarTintColor:);                                  
        SEL swizzledSelector = @selector(hook_setBarTintColor:);                                 
        Method originalMethod = class_getInstanceMethod(class, originalSelector);  
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);  
        BOOL didAddMethod =                                                        
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));                   
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));           
        } else {                                                                   
            method_exchangeImplementations(originalMethod, swizzledMethod);        
        }
    });
}

- (void)hook_setBarTintColor:(UIColor*)barTintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
        [self setNormalBarTintColor:barTintColor];
    }
    [self hook_setBarTintColor:barTintColor];
}

- (UIColor *)nightBarTintColor {
    return objc_getAssociatedObject(self, &nightBarTintColorKey) ? : ([DKNightVersionManager useDefaultNightColor] ? self.defaultNightBarTintColor : self.barTintColor);
}

- (void)setNightBarTintColor:(UIColor *)nightBarTintColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [self setBarTintColor:nightBarTintColor];
    }
    objc_setAssociatedObject(self, &nightBarTintColorKey, nightBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalBarTintColor {
    return objc_getAssociatedObject(self, &normalBarTintColorKey);
}

- (void)setNormalBarTintColor:(UIColor *)normalBarTintColor {
    objc_setAssociatedObject(self, &normalBarTintColorKey, normalBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)defaultNightBarTintColor {
    BOOL notUIKitSubclass = [self isKindOfClass:[UITabBar class]] && ![NSStringFromClass(self.class) containsString:@"UI"];
    if ([self isMemberOfClass:[UITabBar class]] || notUIKitSubclass) {
        return UIColorFromRGB(0x444444);
    } else {
        UIColor *resultColor = self.normalBarTintColor ?: [UIColor clearColor];
        return resultColor;
    }
}

@end
