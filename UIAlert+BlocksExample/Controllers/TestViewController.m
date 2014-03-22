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

    [[[UIAlertView alloc] initWarningWithMessage:@"Some warning message"] show];

    [[[UIAlertView alloc] initWarningWithMessage:@"Warning with cancel block" andCancelBlock:^{
        
        [[[UIAlertView alloc] initWithTitle:@"Block" message:@"It is cancel block"] show];
        
    }] show];
    
    [[[UIAlertView alloc] initWithTitle:@"Test 2 blocks" message:@"2 blocks test.\nAre you agree?" cancelButtonTitle:@"NO" cancelBlock:^{
        
        [[[UIAlertView alloc] initWithTitle:@"Block NO" message:@"It is cancel block"] show];
        
    } proceedButtonTitle:@"YES" proceedBlock:^{
        
        [[[UIAlertView alloc] initWithTitle:@"Block YES" message:@"It is proceed block"] show];

    }] show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
