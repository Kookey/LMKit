//
//  NSDictionary+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSDictionary+LM.h"

@implementation NSDictionary (LM)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [strM appendFormat:@"\n\t%@ = %@\n", key, obj];
        } else {
            [strM appendFormat:@"\t%@ = %@;\n", key, obj];
        }
        
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
