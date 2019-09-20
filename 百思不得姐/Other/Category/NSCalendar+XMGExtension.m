//
//  NSCalendar+XMGExtension.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/20.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "NSCalendar+XMGExtension.h"

@implementation NSCalendar (XMGExtension)

+ (instancetype)calendar{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}

@end
