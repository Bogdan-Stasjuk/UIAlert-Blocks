//
//  UIAlertView+Blocks.m
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "UIAlert+Blocks.h"

#import <objc/runtime.h>


#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define EmptyString @""


@interface UIAlertView () <UIAlertViewDelegate>

@end


@implementation UIAlertView (Blocks)

static NSString *cancelBlockKey = @"alertViewCancelBlock";
static NSString *proceedBlockKey = @"alertViewProceedBlock";


#pragma mark - Public methods

#pragma mark -Static

+ (NSString *)titleFor:(UIAlertTitleType)alertTitleType {
    switch (alertTitleType) {
        case UIAlertTitleWarning:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_WARNING", nil, [NSBundle mainBundle], @"Warning", @"Title 'Warning' for UIAlertView");
        case UIAlertTitleInfo:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_INFO", nil, [NSBundle mainBundle], @"Information", @"Title 'Information' for UIAlertView");
        case UIAlertTitleConfirm:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_CONFIRM", nil, [NSBundle mainBundle], @"Confirmation", @"Title 'Confirmation' for UIAlertView");
        case UIAlertTitleError:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_ERROR", nil, [NSBundle mainBundle], @"Error", @"Title 'Error' for UIAlertView");
            
        default:
            ALog("There is no such alertTitleType in UIAlertTitleType enum. Please add the missing record.");
            return EmptyString;
    }
}

+ (NSString *)buttonTitleFor:(UIAlertButtonType)alertButtonType {
    switch (alertButtonType) {
        case UIAlertButtonNo:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_NO", nil, [NSBundle mainBundle], @"NO", @"Title 'NO' for UIAlertView's button");
        case UIAlertButtonOk:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_OK", nil, [NSBundle mainBundle], @"OK", @"Title 'OK' for UIAlertView's button");
        case UIAlertButtonYes:
            return NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_YES", nil, [NSBundle mainBundle], @"YES", @"Title 'YES' for UIAlertView's button");
        default:
            ALog("There is no such alertButtonType in UIAlertButtonType enum. Please add the missing record.");
            return EmptyString;
    }
}


#pragma mark -Nonstatic

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    return [self initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message {
    return [self initWithTitle:[[self class] titleFor:titleType] message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    return [self initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message buttonType:(UIAlertButtonType)buttonType {
    NSString *title = [[self class] titleFor:titleType];
    NSString *btnTitle = [[self class] buttonTitleFor:buttonType];
    return [self initWithTitle:title message:message buttonTitle:btnTitle];
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
        buttonType:(UIAlertButtonType)buttonType block:(void(^)())block {
    NSString *title = [[self class] titleFor:titleType];
    NSString *btnTitle = [[self class] buttonTitleFor:buttonType];
    return [self initWithTitle:title message:message buttonTitle:btnTitle block:block];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  buttonTitle:(NSString *)buttonTitle block:(void(^)())block {
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    if (self) {
        [self setAssociatedBlock:block usingKey:cancelBlockKey];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)())cancelBlock
 proceedButtonTitle:(NSString *)proceedButtonTitle proceedBlock:(void(^)())proceedBlock {
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:proceedButtonTitle, nil];
    if (self) {
        [self setAssociatedBlock:cancelBlock usingKey:cancelBlockKey];
        [self setAssociatedBlock:proceedBlock usingKey:proceedBlockKey];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
       cancelButtonType:(UIAlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
      proceedButtonType:(UIAlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock
{
    NSString *cancelBtnTitle = [[self class] buttonTitleFor:cancelButtonType];
    NSString *proceedBtnTitle = [[self class] buttonTitleFor:proceedButtonType];
    return [self initWithTitle:title message:message cancelButtonTitle:cancelBtnTitle cancelBlock:cancelBlock proceedButtonTitle:proceedBtnTitle proceedBlock:proceedBlock];
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
       cancelButtonType:(UIAlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
      proceedButtonType:(UIAlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock
{
    NSString *title = [[self class] titleFor:titleType];
    NSString *cancelBtnTitle = [[self class] buttonTitleFor:cancelButtonType];
    NSString *proceedBtnTitle = [[self class] buttonTitleFor:proceedButtonType];
    return [self initWithTitle:title message:message cancelButtonTitle:cancelBtnTitle cancelBlock:cancelBlock proceedButtonTitle:proceedBtnTitle proceedBlock:proceedBlock];
}


#pragma mark - Private methods

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self executeBlockIfExistForKey:cancelBlockKey];
    } else {
        [self executeBlockIfExistForKey:proceedBlockKey];
    }
}

#pragma mark -other

- (void)setAssociatedBlock:(void(^)())block usingKey:(NSString *)key {
    objc_setAssociatedObject(self, (__bridge void *)(key), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())getAssociatedBlockForKey:(NSString *)key {
    return (__bridge void (^)())((__bridge void *)(objc_getAssociatedObject(self, (__bridge void *)(key))));
}

- (void)executeBlockIfExistForKey:(NSString *)key {
    void(^block)() = [self getAssociatedBlockForKey:key];
    if (block) {
        block();
    }
}

@end
