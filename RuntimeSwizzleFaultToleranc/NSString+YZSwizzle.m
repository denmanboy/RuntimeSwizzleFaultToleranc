//
//  NSString+YZSwizzle.m
//  YZValue
//
//  Created by denman on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSString+YZSwizzle.h"
#import "YZSwizzle.h"
@implementation NSString (YZSwizzle)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class], @selector(substringFromIndex:),@selector(yz_substringFromIndex:));
        yz_swizzleSelector([self class], @selector(substringToIndex:),  @selector(yz_substringToIndex:));
        yz_swizzleSelector([self class], @selector(substringFromIndex:),@selector(yz_substringFromIndex:));
        yz_swizzleSelector([self class], @selector(substringWithRange:),@selector(yz_substringWithRange:));
    });
}
- (NSString *)yz_substringFromIndex:(NSUInteger)from
{
    if ((NSInteger)from < 0) {
        DLog(@"[%@]类 参数为负数",NSStringFromClass([self class]));
        return nil;
    }else if (self.length >= from){
        return [self yz_substringFromIndex:from];
    }else{
        DLog(@"[%@]类 长度越界",NSStringFromClass([self class]));
    }
    return nil;
}
- (NSString *)yz_substringToIndex:(NSUInteger)to
{
    if ((NSInteger)to < 0) {
        DLog(@"[%@]类 参数为负数",NSStringFromClass([self class]));
        return nil;
    }else if (self.length >= to){
        return [self yz_substringToIndex:to];
    }else{
        DLog(@"[%@]类 长度越界",NSStringFromClass([self class]));
    }
    return nil;
}
- (NSString *)yz_substringWithRange:(NSRange)range
{
    if ((NSInteger)range.location < 0){
        DLog(@"[%@]类 参数为负数",NSStringFromClass([self class]));
        return nil;
    }else if (self.length >= range.location + range.length){
        return [self yz_substringWithRange:range];
    }else{
        DLog(@"[%@]类 长度越界",NSStringFromClass([self class]));
    }
    return nil;
}
@end
