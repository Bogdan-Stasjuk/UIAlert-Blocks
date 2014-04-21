//
//  UIAlertView+Blocks.m
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "UIAlertView+Blocks.h"

#import <objc/runtime.h>


#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define EmptyString @""


@interface UIAlertView () <UIAlertViewDelegate>

@end


@implementation UIAlertView (Blocks)

static NSString *cancelBlockKey = @"alertViewCancelBlock";
static NSString *proceedBlockKey = @"alertViewProceedBlock";


#pragma mark - Public methods

#pragma mark -static

+ (NSString *)titleFor:(UIAlertTitleType)alertTitleType
{
    NSString *title = EmptyString;
    switch (alertTitleType) {
        case UIAlertTitleWarning:
            title = NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_WARNING", nil, [NSBundle mainBundle], @"Warning", @"Title 'Warning' for UIAlertView");
            break;
        case UIAlertTitleInfo:
            title = NSLocalizedStringWithDefaultValue(@"UIALERT_TITLE_INFO", nil, [NSBundle mainBundle], @"Information", @"Title 'Information' for UIAlertView");
            break;
        default:
            ALog("There is no such alertTitleType in UIAlertTitleType enum. Please add the missing record.");
            break;
    }
    return title;
}

+ (NSString *)buttonTitleFor:(UIAlertButtonType)alertButtonType
{
    NSString *title = EmptyString;
    switch (alertButtonType) {
        case UIAlertButtonNo:
            title = NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_NO", nil, [NSBundle mainBundle], @"NO", @"Title 'NO' for UIAlertView's button");
            break;
        case UIAlertButtonOk:
            title = NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_OK", nil, [NSBundle mainBundle], @"OK", @"Title 'OK' for UIAlertView's button");
            break;
        case UIAlertButtonYes:
            title = NSLocalizedStringWithDefaultValue(@"UIALERT_BUTTON_TITLE_YES", nil, [NSBundle mainBundle], @"YES", @"Title 'YES' for UIAlertView's button");
            break;
        default:
            ALog("There is no such alertButtonType in UIAlertButtonType enum. Please add the missing record.");
            break;
    }
    return title;
}


#pragma mark -nonstatic

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:[[self class] buttonTitleFor:UIAlertButtonOk] otherButtonTitles:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
{
    NSString *title = [[self class] titleFor:titleType];
    self = [self initWithTitle:title message:message];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
        buttonType:(UIAlertButtonType)buttonType block:(void(^)())block
{
    NSString *title = [[self class] titleFor:titleType];
    NSString *btnTitle = [[self class] buttonTitleFor:buttonType];
    self = [self initWithTitle:title message:message buttonTitle:btnTitle block:block];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  buttonTitle:(NSString *)buttonTitle block:(void(^)())block
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil];
    if (self) {
        
        [self setAssociatedBlock:block usingKey:cancelBlockKey];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)())cancelBlock
 proceedButtonTitle:(NSString *)proceedButtonTitle proceedBlock:(void(^)())proceedBlock
{
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
    self = [self initWithTitle:title message:message cancelButtonTitle:cancelBtnTitle cancelBlock:cancelBlock proceedButtonTitle:proceedBtnTitle proceedBlock:proceedBlock];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message
       cancelButtonType:(UIAlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
      proceedButtonType:(UIAlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock
{
    NSString *title = [[self class] titleFor:titleType];
    NSString *cancelBtnTitle = [[self class] buttonTitleFor:cancelButtonType];
    NSString *proceedBtnTitle = [[self class] buttonTitleFor:proceedButtonType];
    self = [self initWithTitle:title message:message cancelButtonTitle:cancelBtnTitle cancelBlock:cancelBlock proceedButtonTitle:proceedBtnTitle proceedBlock:proceedBlock];
    if (self) {
        
    }
    return self;
}


#pragma mark - Private methods

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        
        [self executeBlockIfExistForKey:cancelBlockKey];
        
    } else {
        
        [self executeBlockIfExistForKey:proceedBlockKey];
    }
}

#pragma mark -other

- (void)setAssociatedBlock:(void(^)())block usingKey:(NSString *)key
{
    objc_setAssociatedObject(self, (__bridge void *)(key), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())getAssociatedBlockForKey:(NSString *)key
{
    return (__bridge void (^)())((__bridge void *)(objc_getAssociatedObject(self, (__bridge void *)(key))));
}

- (void)executeBlockIfExistForKey:(NSString *)key
{
    void(^block)() = [self getAssociatedBlockForKey:key];
    if (block) {
        
        block();
    }
}

@end
