UIAlert-Blocks
==============

A category on UIAlertView for using blocks instead of delegation methods with enums for most standard titles and button names.

##Enums for titles and buttons

```objc
typedef NS_ENUM(NSUInteger, UIAlertTitleType)
{
    UIAlertTitleWarning,
    UIAlertTitleInfo,
};

typedef NS_ENUM(NSUInteger, UIAlertButtonType)
{
    UIAlertButtonOk,
    UIAlertButtonYes,
    UIAlertButtonNo,
};
```

All names can be localized or redefined in Localizable.strings files using key-value pairs below:

```objc
 // UIAlert+Blocks button titles
 "UIALERT_BUTTON_TITLE_YES"  = "YES";
 "UIALERT_BUTTON_TITLE_NO"   = "NO";
 "UIALERT_BUTTON_TITLE_OK"   = "OK";
 
 // UIAlert+Blocks titles
 "UIALERT_TITLE_WARNING"     = "Warning";
 "UIALERT_TITLE_INFO"        = "Information";
```

##Static methods

```objc
+ (NSString *)titleFor:(UIAlertTitleType)alertTitleType;
+ (NSString *)buttonTitleFor:(UIAlertButtonType)alertButtonType;
```

##Nonstatic methods

```objc
- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitleType:(UIAlertTitleType)titleType message:(NSString *)message;

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
```


Demo
====

Clone project and run it. You can find examples of usage at TestViewController.m.


Compatibility
=============

This class has been tested back to iOS 6.0.


Installation
============

__Cocoapods__: `pod 'UIAlert+Blocks'`<br />
__Manual__: Copy the __UIAlert+Blocks__ folder in your project<br />

Import header in your project. .pch is a good place ;)

    #import "UIAlert+Blocks.h"

License
=======

This code is released under the MIT License. See the LICENSE file for
details.