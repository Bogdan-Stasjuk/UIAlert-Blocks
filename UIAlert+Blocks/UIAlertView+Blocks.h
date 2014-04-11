//
//  UIAlertView+Blocks.h
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

typedef NS_ENUM(NSUInteger, UIAlertTitleType)
{
    UIAlertTitleWarning,
    UIAlertTitleInfo,
};

typedef NS_ENUM(NSUInteger, UIAlertButtonType)
{
    UIAlertButtonOk,
    UIAlertButtonYes,
    UIAlertButtonNo,
};


@interface UIAlertView (Blocks)

#pragma mark - Methods

#pragma mark -static

+ (NSString *)getTitle:(UIAlertTitleType)alertTitleType;
+ (NSString *)getButtonTitle:(UIAlertButtonType)alertButtonType;

#pragma mark -nonstatic

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message;

- (id)initWithTitle:(NSString *)title message:(NSString *)message
        buttonTitle:(NSString *)buttonTitle block:(void(^)())block;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
        buttonType:(UIAlertButtonType)buttonType block:(void(^)())block;

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)())cancelBlock
 proceedButtonTitle:(NSString *)proceedButtonTitle proceedBlock:(void(^)())proceedBlock;
- (id)initWithTitle:(NSString *)title message:(NSString *)message
   cancelButtonType:(UIAlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
  proceedButtonType:(UIAlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
  cancelButtonType:(UIAlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
 proceedButtonType:(UIAlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock;

@end
