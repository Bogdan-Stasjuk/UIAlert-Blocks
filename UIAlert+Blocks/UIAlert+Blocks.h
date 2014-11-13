//
//  UIAlertView+Blocks.h
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

/*
 key-value pairs for Localizable.strings
 
 // UIAlertView button's titles
 "UIALERT_BUTTON_TITLE_YES"  = "YES";
 "UIALERT_BUTTON_TITLE_NO"   = "NO";
 "UIALERT_BUTTON_TITLE_OK"   = "OK";
 
 // UIAlertView's titles
 "UIALERT_TITLE_WARNING"     = "Warning";
 "UIALERT_TITLE_INFO"        = "Information";
 "UIALERT_TITLE_CONFIRM"     = "Confirmation";
 "UIALERT_TITLE_ERROR"       = "Error";
*/

typedef NS_ENUM(UInt8, UIAlertTitleType) {
    UIAlertTitleWarning,
    UIAlertTitleInfo,
    UIAlertTitleConfirm,
    UIAlertTitleError,
};

typedef NS_ENUM(UInt8, UIAlertButtonType) {
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
