//
//  UIViewController+WhRouter.h
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WhRouter)

// present具体执行
- (void)wh_presentViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion;

// dismiss具体执行
- (void)wh_dismissViewControllerAnimated:(BOOL)animated
                              completion:(void (^)())completion;

// dismiss到第一个present的控制器
- (void)wh_dismissToRootViewControllerAnimated:(BOOL)animated
                                    completion:(void (^)())completion;

// 接受pop、dismiss回传的值
- (void)wh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic;

@end
