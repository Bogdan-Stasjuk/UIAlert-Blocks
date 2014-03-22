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

NSString *warning   = @"Warning";
NSString *ok        = @"OK";

static NSString *cancelBlockKey = @"alertViewCancelBlock";
static NSString *proceedBlockKey = @"alertViewProceedBlock";


#pragma mark - Public methods

#pragma mark -init

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:ok otherButtonTitles:nil];
    if (self) {
        
    }
    return self;
}

- (id)initWarningWithMessage:(NSString *)message
{
    self = [self initWithTitle:warning message:message];
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
