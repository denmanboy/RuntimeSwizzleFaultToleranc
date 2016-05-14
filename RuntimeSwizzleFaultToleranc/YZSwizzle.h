//
//  YZSwizzle.h
//  YZValue
//
//  Created by denman on 15/10/8.
//  Copyright © 2015年 sina. All rights reserved.
//

#ifndef YZSwizzle_h
#define YZSwizzle_h
#import <objc/runtime.h>
typedef id (*MethodIMP) (id,SEL);
typedef id (*MethodIMP1) (id,SEL,id);
typedef id (*MethodIMP2) (id,SEL,id,id);
typedef void (*VMethodIMP) (id,SEL);
typedef void (*VMethodIMP1) (id,SEL,id);
typedef void (*VMethodIMP2) (id,SEL,id,id);
#ifdef DEBUG 
# define DLog(format, ...) NSLog(@"([文件名:%s] [行号:%d] [函数名:%s])"format, __FILE__, __LINE__,__FUNCTION__, ##__VA_ARGS__)
#else
# define DLog(format, ...)
#endif

/**
 *  交换IMP
 *
 *  @param theClass         Class
 *  @param originalSelector 原来的方法selector
 *  @param swizzledSelector 欲交换方法selector
 *
 *  @return
 */
static inline void yz_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
/**
 *  动态添加一个Method
 *
 *  @param theClass 欲添加方法一类
 *  @param selector 方法的selector
 *  @param method   方法
 *
 *  @return 是否成功
 */
static inline BOOL yz_addMethod(Class theClass, SEL selector, Method method){
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

#endif /* YZSwizzle_h */
