//
//  UIAlertView+Blocks.h
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

/*
 key-value pairs for Localizable.strings
 
 // UIAlert+Blocks button titles
 "UIALERT_BUTTON_TITLE_YES"  = "YES";
 "UIALERT_BUTTON_TITLE_NO"   = "NO";
 "UIALERT_BUTTON_TITLE_OK"   = "OK";
 
 // UIAlert+Blocks titles
 "UIALERT_TITLE_WARNING"     = "Warning";
 "UIALERT_TITLE_INFO"        = "Information";
 */

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

+ (NSString *)titleFor:(UIAlertTitleType)alertTitleType;
+ (NSString *)buttonTitleFor:(UIAlertButtonType)alertButtonType;

#pragma mark -nonstatic

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message;

- (id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message buttonType:(UIAlertButtonType)buttonType;


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