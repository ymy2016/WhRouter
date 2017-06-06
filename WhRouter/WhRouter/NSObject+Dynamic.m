//
//  NSObject+Dynamic.m
//  WhRouter
//
//  Created by 伟华 on 17/3/24.
//  Copyright © 2017年 MG. All rights reserved.
//

#import "NSObject+Dynamic.h"
#import <objc/runtime.h>

@implementation NSObject (Dynamic)

// 动态检测，该project中是否含有viewController类
- (BOOL)dynamicCheckIsExistClassWithviewController:(NSString *)viewController{
    
    // 动态创建类
    NSString *classStr = [NSString stringWithFormat:@"%@",viewController];
    const char *className = [classStr cStringUsingEncoding:NSASCIIStringEncoding];
    
    Class newClass = objc_getClass(className);
    if (newClass == nil) {
        
        // 进入该判断,表示该project里面，没有该类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        objc_registerClassPair(newClass);
        @throw [NSException exceptionWithName:@"路由错误" reason:@"该project中没有该类" userInfo:nil];
        return NO;
    }
    
    return YES;
}

// 动态传递数据，kvc
- (void)dynamicDeliverWithViewController:(UIViewController *)viewController
                                     dic:(NSDictionary *)dic{
    
    // 处理传递数据
    if (dic != nil) {
        
        // 遍历字典
        [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            // 检测vc对象中是否存在key属性
            if ([self dynamicCheckIsExistPropertyWithInstance:viewController verifyPropertyName:key]) {
                // 存在，则进行kvc赋值
                [viewController setValue:obj forKey:key];
            }
            
        }];
    }
}

// 动态检测instance对象里面是否存在verifyPropertyName属性
- (BOOL)dynamicCheckIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    // 使用C语言函数class_copyPropertyList，获取类的属性列表，需要进行内存释放，C语言内存管理不受ARC影响
    free(properties);
    return NO;
}
@end
