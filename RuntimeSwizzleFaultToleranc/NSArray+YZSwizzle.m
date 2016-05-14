//
//  NSArray+YZSwizzle.m
//  YZValue
//
//  Created by dengyanzhou on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSArray+YZSwizzle.h"
#import "YZSwizzle.h"

@implementation NSArray (YZSwizzle)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class],@selector(objectAtIndex:),@selector(yz_objectAtIndex:));
        yz_swizzleSelector([self class],@selector(arrayWithObjects:count:),@selector(yz_arrayWithObjects:count:));
    });
}
//数组越界容错
- (id)yz_objectAtIndex:(NSUInteger)index
{
    if ((NSInteger)index < 0) {
        DLog(@"[%@] index = %ld为负数",[self class],(NSInteger)index);
        return nil;
    }else if(index < self.count){
        return [self yz_objectAtIndex:index];
    }else{
        DLog(@"[%@]  index = %lul越界",[self class],(unsigned long)index);
    }
    return nil;
}
+ (id)yz_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    id validObjects[cnt];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < cnt; i++){
        if (objects[i]){
            validObjects[count] = objects[i];
            count++;
        }else{
            DLog(@"[%@] 数组元素有为空的情况",[self class]);
            return nil;
        }
    }
    return [self yz_arrayWithObjects:validObjects count:count];
}
@end
