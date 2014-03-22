//
//  TestViewController.h
//  UIAlert+Blocks
//
//  Created by Bogdan Stasjuk on 3/22/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

@interface TestViewController : UIViewController

#pragma mark - Unavailable methods

- (id)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder: not available")));
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __attribute__((unavailable("initWithNibName:bundle: not available")));

@end
