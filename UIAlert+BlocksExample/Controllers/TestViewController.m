//
//  TestViewController.m
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "TestViewController.h"

#import "UIAlert+Blocks.h"


@interface TestViewController ()

@end


@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[UIAlertView alloc] initWithTitle:[UIAlertView titleFor:UIAlertTitleWarning]
                                message:@"Warning with cancel block"
                      cancelButtonTitle:@"Cancel"
                            cancelBlock:^{
                                 [[[UIAlertView alloc] initWithTitleType:UIAlertTitleInfo message:@"It is cancel block" buttonType:UIAlertButtonOk] show];
                            }
                     proceedButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonOk] proceedBlock:nil] show];
    
    [[[UIAlertView alloc] initWithTitle:@"Test 2 blocks"
                                message:@"2 blocks test.\nDo you agree?"
                      cancelButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonNo]
                            cancelBlock:^{
                                [[[UIAlertView alloc] initWithTitle:@"Block NO" message:@"It is cancel block" buttonTitle:[UIAlertView buttonTitleFor:UIAlertButtonOk] block:nil] show];
                            }
                     proceedButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonYes]
                           proceedBlock:^{
                               [[[UIAlertView alloc] initWithTitleType:UIAlertTitleWarning message:@"Your app is blocked"] show];
                           }] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
