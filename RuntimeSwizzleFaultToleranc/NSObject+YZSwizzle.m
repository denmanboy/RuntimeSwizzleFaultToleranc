//
//  NSObject+YZSwizzle.m
//  YZValue
//
//  Created by denman on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSObject+YZSwizzle.h"
#import "YZSwizzle.h"

@implementation NSObject (YZSwizzle)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class],@selector(performSelector:), @selector(yz_performSelector:));
        yz_swizzleSelector([self class],@selector(performSelector:withObject:), @selector(yz_performSelector:withObject:));
        yz_swizzleSelector([self class],@selector(performSelector:withObject:withObject:), @selector(yz_performSelector:withObject:withObject:));
        yz_swizzleSelector([self class],@selector(performSelector:withObject:afterDelay:inModes:), @selector(yz_performSelector:withObject:afterDelay:inModes:));
        yz_swizzleSelector([self class],@selector(performSelector:withObject:afterDelay:), @selector(yz_performSelector:withObject:afterDelay:));
    });
}
- (id)yz_performSelector:(SEL)aSelector
{
    if ([self respondsToSelector:aSelector]) {
        if ([self isHasReturnValue:aSelector]) {
            MethodIMP iMP = (MethodIMP)[self methodForSelector:aSelector];
            iMP(self,aSelector);
        }else{
            VMethodIMP iMP = (VMethodIMP)[self methodForSelector:aSelector];
            iMP(self, aSelector);return nil;
        }
    }else{
        DLog(@"[%@]类 %@方法没有实现",[self class],NSStringFromSelector(aSelector));
        return nil;
    }
    return nil;
}
- (id)yz_performSelector:(SEL)aSelector
              withObject:(id)object
{
    if ([self respondsToSelector:aSelector]) {
        if ([self isHasReturnValue:aSelector]) {
            MethodIMP1 iMP = (MethodIMP1)[self methodForSelector:aSelector];
            return iMP(self, aSelector, object);
        }else{
            VMethodIMP1 iMP = (VMethodIMP1)[self methodForSelector:aSelector];
            iMP(self, aSelector, object);return nil;
        }
    }else{
        DLog(@"[%@]类 方法没有实现",NSStringFromSelector(aSelector));
        return nil;
    }
}
-(id)yz_performSelector:(SEL)aSelector
             withObject:(id)object1
             withObject:(id)object2
{
    if ([self respondsToSelector:aSelector]) {
        if ([self isHasReturnValue:aSelector]) {
            MethodIMP2 iMP = (MethodIMP2)[self methodForSelector:aSelector];
            return iMP(self, aSelector, object1, object2);
        }else{
            VMethodIMP2 iMP = (VMethodIMP2)[self methodForSelector:aSelector];
            iMP(self, aSelector, object1, object2);return nil;
        }
    }else{
        DLog(@"[%@] 方法没有实现",NSStringFromSelector(aSelector));
        return nil;
    }
}
- (void)yz_performSelector:(SEL)aSelector
                withObject:(id)anArgument
                afterDelay:(NSTimeInterval)delay
                   inModes:(NSArray<NSString *> *)modes
{
    if ([self respondsToSelector:aSelector]) {
        [self yz_performSelector:aSelector withObject:anArgument afterDelay:delay inModes:modes];
    }else{
        DLog(@"[%@]类 %@方法没有实现",[self class],NSStringFromSelector(aSelector));
    }
}
- (void)yz_performSelector:(SEL)aSelector
                withObject:(nullable id)anArgument
                afterDelay:(NSTimeInterval)delay
{
    
    if ([self respondsToSelector:aSelector]) {
        [self yz_performSelector:aSelector withObject:anArgument afterDelay:delay];
    }else{
        DLog(@"[%@]类 %@方法没有实现",[self class],NSStringFromSelector(aSelector));
    }
}
- (BOOL)isHasReturnValue:(SEL)aSelector
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (signature){
        const char *returnType = signature.methodReturnType;
        //返回值为void
        if (strcmp(returnType, @encode(void)) == 0){
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}
@end
