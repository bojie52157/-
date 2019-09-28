//
//  XMGTopicVideoView.m
//  4期-百思不得姐
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import "XMGTopic.h"
#import "XMGSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
@interface XMGTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startPlay;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@end

@implementation XMGTopicVideoView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
   self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
   [_startPlay addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];

}

- (void)seeBig
{
    XMGSeeBigViewController *seeBig = [[XMGSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}
    
- (void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

#pragma mark - 播放视频
- (void)playVideo{
   //1 创建AVPlayerItem
    self.currentPlayerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.topic.videouri]];

    //2.把AVPlayerItem放在AVPlayer上
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.currentPlayerItem];

    //3 再把AVPlayer放到 AVPlayerLayer上
    AVPlayerLayer *avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    avplayerLayer.frame = self.layer.bounds;
    avplayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;

    //4 最后把 AVPlayerLayer放到self.view.layer上(也就是需要放置的视图的layer层上)
    [self.layer addSublayer:avplayerLayer];
    [self.player play];
}


@end
