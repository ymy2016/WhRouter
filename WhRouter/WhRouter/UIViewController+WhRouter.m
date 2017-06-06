//
//  UIViewController+WhRouter.m
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "UIViewController+WhRouter.h"

@implementation UIViewController (WhRouter)

// present具体执行
- (void)wh_presentViewController:(UIViewController *)viewController
                        animated:(BOOL)animated
                      completion:(void (^)())completion{

    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self presentViewController:viewController animated:animated completion:completion];
    [CATransaction commit];
}


// dismiss具体执行
- (void)wh_dismissViewControllerAnimated:(BOOL)animated
                              completion:(void (^)())completion{
  
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [self dismissViewControllerAnimated:YES completion:nil];
    [CATransaction commit];
}

// dismiss到第一个present的控制器
- (void)wh_dismissToRootViewControllerAnimated:(BOOL)animated
                                    completion:(void (^)())completion{
    
    /**
     1、注意区分presentedViewController与presentingViewController
     2、通过present，A->B
     3、A.presentedViewController 是B
     4、B.presentingViewController 是A
     */
    
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [vc dismissViewControllerAnimated:YES completion:nil];
    [CATransaction commit];
}

// 接受pop、dismiss回传的值
- (void)wh_receivePreviousControllerWithParamsDic:(NSDictionary *)ParamsDic{

}

@end
