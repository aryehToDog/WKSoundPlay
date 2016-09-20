//
//  ViewController.m
//  WKSoundPlay
//
//  Created by 阿拉斯加的狗 on 16/9/20.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WKAudioTool.h"

@interface ViewController ()

/* 播放器的对象 */
@property (nonatomic, strong) AVAudioPlayer *player;

/* 录音对象 */
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置同时进行录音及播放模式
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
}

/** 播放音乐及录音 */
- (IBAction)startSound {
    
    [WKAudioTool playMusicWithName:@"1201111234.mp3"];
    
    //开始录音
    [self.recorder record];
}

/** 停止播放 */
- (IBAction)stopSound {
    [WKAudioTool pauseMusicWithName: @"1201111234.mp3"];
    
    //停止录音
    [self.recorder stop];
    
     self.player = nil;
}

/** 播放音频及录音 */
- (IBAction)playVoice {
    
    [WKAudioTool playSoundWithName:@"buyao.wav"];
    
    //开始录音
    [self.recorder record];
}



#pragma mark - 懒加载代码
- (AVAudioRecorder *)recorder
{
    if (_recorder == nil) {
        // 1.获取音频存储的位置(录制的音频是一个文件,需要存在某一个位置)
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 2.拼接音频的名称
        NSString *filePath = [path stringByAppendingPathComponent:@"123.caf"];
        
        NSURL *url = [NSURL URLWithString:filePath];
        
        // 2.创建录音对象(settings中用于设置采样率/比特率)
        self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:nil];
    }
    return _recorder;
}


#pragma mark - 懒加载代码
- (AVAudioPlayer *)player
{
    if (_player == nil) {
        // 1.获取资源的URL
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"1201111234.mp3" withExtension:nil];
        
        // 2.创建对应的播放器(一个播放器对应一个URL)
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        // 3.准备播放
        [self.player prepareToPlay];
    }
    return _player;
}

@end
