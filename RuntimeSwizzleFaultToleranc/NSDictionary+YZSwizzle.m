//
//  NSDictionary+YZSwizzle.m
//  YZValue
//
//  Created by denman on 15/10/5.
//  Copyright © 2015年 sina. All rights reserved.
//

#import "NSDictionary+YZSwizzle.h"
#import "YZSwizzle.h"
@implementation NSDictionary (YZSwizzle)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yz_swizzleSelector([self class],@selector(objectForKey:),@selector(yz_objectForKey:));
    });
}

- (id)yz_objectForKey:(id)aKey
{
    if (!aKey){
        DLog(@"[%@] key 为空",[self class]);
        return nil;
    }
    if ([aKey isKindOfClass:NSString.self]
        &&((NSString*)aKey).length == 0) {
        DLog(@"[%@] key 字符创 为@""",[self class]);
        return nil;
    }
    return [self yz_objectForKey:aKey];
}
@end
