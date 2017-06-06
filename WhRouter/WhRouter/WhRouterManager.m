//
//  WhRouterManager.m
//  WhRouter
//
//  Created by 伟华 on 17/3/16.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "WhRouterManager.h"

static WhRouterManager *sharedRouter = nil;
@implementation WhRouterManager

+ (instancetype)router{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [[self alloc] init];
    });

    return sharedRouter;
}

// 寻找当前push、pop需要的导航控制器
- (UINavigationController *)navigationController{
  
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    // 根控制器是Tabbar的情况
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        // 获取到当前选中的控制器
        UITabBarController *vc = (UITabBarController *)rootVC;
        return vc.selectedViewController;
    }
    // 根控制器是Navigation的情况
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        
        return (UINavigationController *)rootVC;;
    }
    // 根控制器是其他类型的情况
    else{
        
        __block UITabBarController *tabbar = nil;
        __block UINavigationController *navigation = nil;
        
        [rootVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[UITabBarController class]]) {
                
                tabbar = (UITabBarController *)obj;
                return;
            }
            else if ([obj isKindOfClass:[UINavigationController class]]){
                
                navigation = (UINavigationController *)obj;
                return;
            }
        }];
        
        if (tabbar != nil) {
            return tabbar.selectedViewController;
        }
        else if (navigation != nil){
            return navigation;
        }
        else{
            @throw [NSException exceptionWithName:@"路由错误" reason:@"该project的控制器中没有导航控制器" userInfo:nil];
        }
    }
}

#pragma mark - push模式
- (void)push:(NSString *)viewController
    animated:(BOOL)animated{
  
    [self push:viewController animated:animated paramsDic:nil isHiddenTabbarWhenPush:NO completion:nil];
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic{

  [self push:viewController animated:animated paramsDic:paramsDic isHiddenTabbarWhenPush:NO completion:nil];
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush{

  [self push:viewController animated:animated paramsDic:paramsDic isHiddenTabbarWhenPush:isHiddenTabbarWhenPush completion:nil];
    
}

- (void)push:(NSString *)viewController
    animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic
isHiddenTabbarWhenPush:(BOOL)isHiddenTabbarWhenPush
  completion:(void(^)())completion{
 
    BOOL isExistClass = [self dynamicCheckIsExistClassWithviewController:viewController];
    if (isExistClass) {
        
        Class newClass =  NSClassFromString(viewController);
        // 动态生成对象
        UIViewController *vc = [[newClass alloc] init];
        
        // 动态传递数据
        [self dynamicDeliverWithViewController:vc dic:paramsDic];
        
        // 调用push
        [self.navigationController wh_PushViewController:vc animated:animated isHiddenTabbarWhenPush:isHiddenTabbarWhenPush completion:completion];
    }
}

#pragma mark - pop模式
// pop回上一级
- (void)popViewControllerAnimated:(BOOL)animated{
    
    [self popViewControllerAnimated:animated paramsDic:nil completion:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic{
    
    [self popViewControllerAnimated:animated paramsDic:paramsDic completion:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated
                        paramsDic:(NSDictionary *)paramsDic
                       completion:(void(^)())completion{

    NSInteger vcCounts = self.navigationController.viewControllers.count;
    UIViewController *vc = self.navigationController.viewControllers[vcCounts - 2];
    if ([vc respondsToSelector:@selector(wh_receivePreviousControllerWithParamsDic:)]) {
        [vc wh_receivePreviousControllerWithParamsDic:paramsDic];
    }
    [self.navigationController wh_popViewController:animated completion:completion];
}

// pop到指定vc
- (void)popToViewController:(NSString *)viewController animated:(BOOL)animated{

    [self popToViewController:viewController animated:animated paramsDic:nil completion:nil];
}

- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic{

    [self popToViewController:viewController animated:animated paramsDic:paramsDic completion:nil];
}

- (void)popToViewController:(NSString *)viewController
                   animated:(BOOL)animated
                  paramsDic:(NSDictionary *)paramsDic
                 completion:(void(^)())completion{
    
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([viewController isEqualToString:NSStringFromClass([vc class])]) {
                
                if ([vc respondsToSelector:@selector(wh_receivePreviousControllerWithParamsDic:)]) {
                    [vc wh_receivePreviousControllerWithParamsDic:paramsDic];
                }
                [self.navigationController wh_popToViewController:vc animated:animated completion:completion];
                return;
            }
            else if (self.navigationController.viewControllers.count == idx+1){
            
                @throw [NSException exceptionWithName:@"路由错误" reason:@"该viewController不在该导航的栈结构中" userInfo:nil];
            }
        }];
}

// popToRoot
- (void)popToRootViewControllerAnimated:(BOOL)animated{

   [self popToRootViewControllerAnimated:animated paramsDic:nil completion:nil];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
                              paramsDic:(NSDictionary *)paramsDic{
 
   [self popToRootViewControllerAnimated:animated paramsDic:paramsDic completion:nil];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
                               paramsDic:(NSDictionary *)paramsDic
                             completion:(void(^)())completion{
        
    // 获取导航的Root控制器、传递paramsDic
    UIViewController *navRootVC = [self.navigationController.viewControllers firstObject];
    if ([navRootVC respondsToSelector:@selector(wh_receivePreviousControllerWithParamsDic:)]) {
        [navRootVC wh_receivePreviousControllerWithParamsDic:paramsDic];
    }
    [self.navigationController wh_popToRootViewController:animated completion:completion];
}

#pragma mark - present模式
- (void)present:(NSString *)viewController animated:(BOOL)animated{
 
    [self present:viewController animated:animated paramsDic:nil completion:nil];
}

- (void)present:(NSString *)viewController
       animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic{
    
    [self present:viewController animated:animated paramsDic:paramsDic completion:nil];
}

- (void)present:(NSString *)viewController
       animated:(BOOL)animated
      paramsDic:(NSDictionary *)paramsDic
     completion:(void(^)())completion{
    
    BOOL isExistClass = [self dynamicCheckIsExistClassWithviewController:viewController];
    if (isExistClass) {
        
        Class newClass =  NSClassFromString(viewController);
        // 动态生成对象
        UIViewController *vc = [[newClass alloc] init];
        
        // 动态传递数据
        [self dynamicDeliverWithViewController:vc dic:paramsDic];
        
        [self.navigationController.topViewController wh_presentViewController:vc animated:animated completion:completion];
    }
}

@end
