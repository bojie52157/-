//
//  XMGTopicPictureView.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/21.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import "XMGSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>
@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation XMGTopicPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    //如果一个控件显示出来的大小和当初设置的frame大小不一致，有可能因为autoresizingMask属性值包含UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight，解决方案：
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}

- (void)seeBig{
    XMGSeeBigViewController *seeBig = [[XMGSeeBigViewController alloc]init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    //网络判断
//    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {//手机自带网络
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
//    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){//fwifi
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
//    }else{//网络有问题
//        self.imageView.image = nil;
//    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //receivedSize 已经接收的图片大小
        //expectedSize 图片总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //下载完毕
        self.progressView.hidden = YES;
    }];

    //gif
    self.gifView.hidden = !topic.is_gif;
    if (topic.is_gif) {//是gif图片
        [self.imageView xmg_setImage:[NSURL URLWithString:topic.large_image]];
    }
    //查看大图
    if (topic.isBigPicture) {//超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }


}

@end
