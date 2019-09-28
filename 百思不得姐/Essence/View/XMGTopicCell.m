//
//  XMGTopicCell.m
//  百思不得姐
//
//  Created by 孙 on 2019/9/19.
//  Copyright © 2019 小情调. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGComment.h"
#import "XMGUser.h"
#import "XMGTopicVideoView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicPictureView.h"

@interface XMGTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/// 图片控件
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/// 声音控件
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/// 视频控件
@property (nonatomic, weak) XMGTopicVideoView *videoView;

@end

@implementation XMGTopicCell

#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView viewFormXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView viewFormXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView viewFormXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

#pragma mark -初始化
- (IBAction)more{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击收藏");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击举报");
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    
    
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;

    //设置按钮
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_cmt) {//有最热评论
        self.topCmtView.hidden = NO;
        NSString *username = topic.top_cmt.user.username;//用户名
        NSString *content = topic.top_cmt.content;//评论内容
        if (topic.top_cmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else{//没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    //中间内容
#pragma mark - 根据XMGTopic模型数据的情况来决定中间添加什么控件（内容）
    if (topic.type == XMGTopicTypeVideo) {//视频
            self.videoView.hidden = NO;
            self.videoView.frame = topic.contentF;
            self.videoView.topic = topic;
            
            self.voiceView.hidden = YES;
            self.pictureView.hidden = YES;
        } else if (topic.type == XMGTopicTypeVoice) { // 音频
            self.voiceView.hidden = NO;
            self.voiceView.frame = topic.contentF;
            self.voiceView.topic = topic;
            
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
        } else if (topic.type == XMGTopicTypeWord) { // 段子
            self.videoView.hidden = YES;
            self.voiceView.hidden = YES;
            self.pictureView.hidden = YES;
        } else if (topic.type == XMGTopicTypePicture) { // 图片
            self.pictureView.hidden = NO;
            self.pictureView.frame = topic.contentF;
            self.pictureView.topic = topic;
            
            self.videoView.hidden = YES;
            self.voiceView.hidden = YES;
    }
}



/**
 设置按钮的数字

 @param button 按钮
 @param number 数字
 @param placeholder 占位文字
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%.zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**重写这个方法目的：能够拦截所有设置cell frame的操作，设置cell间距*/
- (void)setFrame:(CGRect)frame{
    frame.size.height -= XMGMargin;
    frame.origin.x = 0;
//    frame.size.width -= 2 * XMGMargin;
    [super setFrame:frame];
}
@end
