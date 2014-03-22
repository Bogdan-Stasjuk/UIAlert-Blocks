//
//  UIAlertView+Blocks.h
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@interface UIAlertView (Blocks)

- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (id)initWarningWithMessage:(NSString *)text;
- (id)initWarningWithMessage:(NSString *)message andCancelBlock:(void(^)())cancel;

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void(^)())cancelBlock
 proceedButtonTitle:(NSString *)proceedButtonTitle proceedBlock:(void(^)())proceedBlock;

@end
