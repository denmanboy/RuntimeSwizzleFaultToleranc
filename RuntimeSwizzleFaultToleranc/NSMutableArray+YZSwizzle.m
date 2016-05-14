//
//  NSMutableArray+YZSwizzle.m
//  YZValue
//
//  Created by dengyanzhou on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSMutableArray+YZSwizzle.h"
#import "YZSwizzle.h"
@implementation NSMutableArray (YZSwizzle)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class], @selector(objectAtIndex:), @selector(yz_objectAtIndex:));
        yz_swizzleSelector([self class], @selector(replaceObjectAtIndex:withObject:), @selector(yz_replaceObjectAtIndex:withObject:));
        yz_swizzleSelector([self class], @selector(addObject:), @selector(yz_addObject:));
        yz_swizzleSelector([self class], @selector(insertObject:atIndex:), @selector(yz_insertObject:atIndex:));
        yz_swizzleSelector([self class], @selector(removeObjectAtIndex:), @selector(yz_removeObjectAtIndex:));
    });
}
- (id)yz_objectAtIndex:(NSInteger)index
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

- (void)yz_addObject:(id)anObject
{
    if (!anObject){
        DLog(@"[%@] 加入的元素为空",[self class]);
        return;
    }
    [self yz_addObject:anObject];
}
- (void)yz_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if ((NSInteger)index < 0) {
        DLog(@"[%@] index = %ld为负数",[self class],(NSInteger)index);
        return;
    }else if (index >= self.count){
        DLog(@"[%@]  index = %lul越界",[self class],(unsigned long)index);
        return;
    }
    if (!anObject){
        DLog(@"[%@] 加入的元素为空",[self class]);
        return;
    }
    [self yz_replaceObjectAtIndex:index withObject:anObject];
}

- (void)yz_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if ((NSInteger)index < 0) {
        DLog(@"[%@] index = %ld为负数",[self class],(NSInteger)index);
        return;
    }else if (index > self.count){
        DLog(@"[%@]  index = %lul越界",[self class],(unsigned long)index);
        return;
    }
    if (!anObject){
        DLog(@"[%@] 加入的元素为空",[self class]);
        return;
    }
    [self yz_insertObject:anObject atIndex:index];
}

- (void)yz_removeObjectAtIndex:(NSUInteger)index{
    if ((NSInteger)index < 0) {
        DLog(@"[%@] index = %ld为负数",[self class],(NSInteger)index);
        return;
    }else if (index >= [self count]) {
        DLog(@"[%@]  index = %lul越界",[self class],(unsigned long)index);
        return;
    }
    [self yz_removeObjectAtIndex:index];
}
@end
