//
//  NSObject+Dynamic.h
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Dynamic)

// 动态检测，project中是否含有viewController类
- (BOOL)dynamicCheckIsExistClassWithviewController:(NSString *)viewController;

// 动态传递数据，kvc
- (void)dynamicDeliverWithViewController:(UIViewController *)viewController
                                     dic:(NSDictionary *)dic;

// 动态检测instance对象里面是否存在verifyPropertyName属性
- (BOOL)dynamicCheckIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName;

@end
