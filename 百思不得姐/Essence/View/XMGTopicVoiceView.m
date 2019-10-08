//
//  XMGTopicVoiceView.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import "XMGTopic.h"
#import "XMGSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
@interface XMGTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *voiceStart;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *currentItem;
@end

@implementation XMGTopicVoiceView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    [self.voiceStart addTarget:self action:@selector(startVoice) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (void)startVoice{
    XMGLog(@"%@",self.topic.voiceuri);
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:[NSURL URLWithString:self.topic.voiceuri] options:nil];
//    NSURL *url = [NSURL URLWithString:self.topic.voiceuri];
    self.currentItem = [[AVPlayerItem alloc]initWithAsset:asset];
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.currentItem];
    [self.player play];
    
}

@end
