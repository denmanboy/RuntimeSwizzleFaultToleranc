//
//  NSMutableDictionary+YZSwizzle.m
//  YZValue
//
//  Created by denman on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSMutableDictionary+YZSwizzle.h"
#import "YZSwizzle.h"
@implementation NSMutableDictionary (YZSwizzle)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class],@selector(objectForKey:),@selector(yz_objectForKey:));
        yz_swizzleSelector([self class], @selector(setObject:forKey:), @selector(yz_setObject:forKey:));
        yz_swizzleSelector([self class], @selector(removeObjectForKey:), @selector(yz_removeObjectForKey:));
        
    });
}
- (id)yz_objectForKey:(id)aKey
{
    if (!aKey){
        DLog(@"[%@] key 为空", [self class]);
        return nil;
    }
    if ([aKey isKindOfClass:NSString.self]
        && ((NSString*)aKey).length == 0) {
        DLog(@"[%@]  key 为@""",[self class]);
        return nil;
    }
    return [self yz_objectForKey:aKey];
}

- (void)yz_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (!aKey){
        DLog(@"[%@] key 为空", [self class]);
        return;
    }
    if (!anObject) {
        DLog(@"[%@] anObject 为空",[self class]);
        return;
    }
    [self yz_setObject:anObject forKey:aKey];
}
- (void)yz_removeObjectForKey:(id)aKey{
    if (!aKey){
        DLog(@"[%@] key 为空", [self class]);
        return;
    }
    if ([aKey isKindOfClass:NSString.self]
        && ((NSString*)(aKey)).length == 0) {
        DLog(@"[%@] key 为@""", [self class]);
        return;
    }
    [self yz_removeObjectForKey:aKey];
}
@end
