//
//  UIAlertView+Blocks.m
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "UIAlertView+Blocks.h"

#import <objc/runtime.h>


@interface UIAlertView () <UIAlertViewDelegate>

@end


@implementation UIAlertView (Blocks)

static NSString *cancelBlockKey = @"alertViewCancelBlock";
static NSString *proceedBlockKey = @"alertViewProceedBlock";


#pragma mark - Public methods

#pragma mark -init

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:[self buttonTitleString:AlertButtonOk] otherButtonTitles:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitleType:(AlertTitleType)titleType message:(NSString *)message
{
    NSString *title = [self titleString:titleType];
    self = [self initWithTitle:title message:message];
    if (self) {
        
    }
    return self;
}

- (id)initWarningWithMessage:(NSString *)message
{
    self = [self initWithTitle:[self titleString:AlertTitleWarning] message:message];
    if (self) {

    }
    return self;
}

- (id)initWarningWithMessage:(NSString *)message andCancelBlock:(void(^)())cancelBlock
{
    self = [self initWarningWithMessage:message];
    if (self) {
        
        [self setAssociatedBlock:cancelBlock usingKey:cancelBlockKey];
        
        self.delegate = self;
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
       cancelButtonType:(AlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
      proceedButtonType:(AlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock
{
    NSString *cancelBtnTitle = [self buttonTitleString:cancelButtonType];
    NSString *proceedBtnTitle = [self buttonTitleString:proceedButtonType];
    self = [self initWithTitle:title message:message cancelButtonTitle:cancelBtnTitle cancelBlock:cancelBlock proceedButtonTitle:proceedBtnTitle proceedBlock:proceedBlock];
    if (self) {
        
    }
    return self;
}

- (id)initWithTitleType:(AlertTitleType)titleType message:(NSString *)message
       cancelButtonType:(AlertButtonType)cancelButtonType cancelBlock:(void(^)())cancelBlock
      proceedButtonType:(AlertButtonType)proceedButtonType proceedBlock:(void(^)())proceedBlock
{
    NSString *title = [self titleString:titleType];
    NSString *cancelBtnTitle = [self buttonTitleString:cancelButtonType];
    NSString *proceedBtnTitle = [self buttonTitleString:proceedButtonType];
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

- (NSString *)titleString:(AlertTitleType)alertTitleType
{
    NSArray *alertTitles = @[
                                @"Warning",
                             ];
    
    if (alertTitleType >= alertTitles.count) {
        
        ALog("alertTitleType >= alertTitles.count");
        
        return EmptyString;
    }
    
    return alertTitles[alertTitleType];
}

- (NSString *)buttonTitleString:(AlertButtonType)alertButtonType
{
    NSArray *alertButtons = @[
                             @"OK",
                             @"YES",
                             @"NO",
                             ];
    
    if (alertButtonType >= alertButtons.count) {
        
        ALog("alertButtonType >= alertButtons.count");
        
        return EmptyString;
    }
    
    return alertButtons[alertButtonType];
}

@end
