//
//  TestViewController.m
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "TestViewController.h"

#import "UIAlertView+Blocks.h"


@interface TestViewController ()

@end


@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[UIAlertView alloc] initWithTitleType:UIAlertTitleWarning message:@"Some warning message"] show];
    
    [[[UIAlertView alloc] initWithTitle:[UIAlertView titleFor:UIAlertTitleWarning]
                                message:@"Warning with cancel block"
                      cancelButtonTitle:@"Cancel"
                            cancelBlock:^{
                                 [[[UIAlertView alloc] initWithTitle:@"Block" message:@"It is cancel block"] show];
                            }
                     proceedButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonOk] proceedBlock:nil] show];
    
    [[[UIAlertView alloc] initWithTitle:@"Test 2 blocks"
                                message:@"2 blocks test.\nAre you agree?"
                      cancelButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonNo]
                            cancelBlock:^{
                                [[[UIAlertView alloc] initWithTitle:@"Block NO" message:@"It is cancel block"] show];
                            }
                     proceedButtonTitle:[UIAlertView buttonTitleFor:UIAlertButtonYes]
                           proceedBlock:^{
                               [[[UIAlertView alloc] initWithTitle:@"Block YES" message:@"It is proceed block"] show];
                           }] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
