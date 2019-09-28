//
//  XMGExtensionConfig.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/21.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGExtensionConfig.h"
#import <MJExtension.h>
#import "XMGTopic.h"
#import "XMGComment.h"

@implementation XMGExtensionConfig

+ (void)load
{
    [XMGTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                @"ID" : @"id",
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}
@end
