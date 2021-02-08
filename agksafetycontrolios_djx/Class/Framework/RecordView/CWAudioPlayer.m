//
//  CWAudioPlayer.m
//  CWAudioTool
//
//  Created by chavez on 2017/9/26.
//  Copyright © 2017年 chavez. All rights reserved.
//

#import "CWAudioPlayer.h"

@interface CWAudioPlayer() <AVAudioPlayerDelegate>



@end

@implementation CWAudioPlayer

singtonImplement(CWAudioPlayer);

- (AVAudioPlayer *)playAudioWith:(NSString *)audioPath {
    [self stopCurrentAudio]; // 播放之前 先结束当前播放
    // 设置为扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *url = [NSURL URLWithString:audioPath];
    if (url == nil) {
        url = [[NSBundle mainBundle] URLForResource:audioPath.lastPathComponent withExtension:nil];
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    NSLog(@"准备播放...%@",url);
    [self.player prepareToPlay];
    
    self.player.delegate = self;
    
    [self.player play];
    return self.player;
}

- (void)resumeCurrentAudio {
    [self.player play];
}

- (void)pauseCurrentAudio {
    [self.player pause];
}

- (void)stopCurrentAudio {
    [self.player stop];
}

- (float)progress {
    return self.player.currentTime / self.player.duration;
}
#pragma mark -------- AVAudioPlayerDelegate -------
// 音频播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
//        self.playerDidFinsh();
    }
}

@end
