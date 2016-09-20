//
//  WKAudioTool.m
//  WKSoundPlay
//
//  Created by 阿拉斯加的狗 on 16/9/20.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKAudioTool.h"
#import <AVFoundation/AVFoundation.h>


@implementation WKAudioTool

static NSMutableDictionary *_soundDict;
static NSMutableDictionary *_musicDict;

+ (void)initialize
{
    _soundDict = [NSMutableDictionary dictionary];
    _musicDict = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithName:(NSString *)soundName
{
    // 1.从字典中取出对应的声音文件的SoundID
    SystemSoundID soundId = [_soundDict[soundName] unsignedIntValue];
    
    // 2.如果取出为空,则创建对应的音效文件
    if (soundId == 0) {
        // 2.1.获取对应音频的URL
        CFURLRef urlRef = (__bridge CFURLRef)([[NSBundle mainBundle] URLForResource:soundName withExtension:nil]);
        
        // 2.2.创建对应的音效文件
        AudioServicesCreateSystemSoundID(urlRef, &soundId);
        
        // 2.3.存到字典中
        [_soundDict setObject:@(soundId) forKey:soundName];
    }
    
    // 3.播放音效
    AudioServicesPlaySystemSound(soundId);
}

+ (void)playMusicWithName:(NSString *)musicName
{
    // 0.判断传入的字符串是否为空
    assert(musicName);
    
    // 1.从字典中取出播放器
    AVAudioPlayer *player = _musicDict[musicName];
    
    // 2.如果取出为空,则创建对应的播放器
    if (player == nil) {
        // 2.1.获取音乐对应的URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        
        // 2.2.创建对应的播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 2.3.将播放器存到字典中
        [_musicDict setObject:player forKey:musicName];
    }
    
    // 3.播放音乐
    [player prepareToPlay];
    [player play];
}

+ (void)pauseMusicWithName:(NSString *)musicName
{
    // 0.判断传入的字符串是否为空
    assert(musicName);
    
    // 1.取出对应的播放器
    AVAudioPlayer *player = _musicDict[musicName];
    
    // 2.暂停歌曲
    if (player && player.isPlaying) {
        [player pause];
    }
}

+ (void)stopMusicWithName:(NSString *)musicName
{
    // 0.判断传入的字符串是否为空
    assert(musicName);
    
    // 1.取出对应的播放器
    AVAudioPlayer *player = _musicDict[musicName];
    
    // 2.停止播放
    if (player) {
        [_musicDict removeObjectForKey:musicName];
    }
}


@end
