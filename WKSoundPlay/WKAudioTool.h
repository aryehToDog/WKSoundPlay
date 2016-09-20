//
//  WKAudioTool.h
//  WKSoundPlay
//
//  Created by 阿拉斯加的狗 on 16/9/20.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAudioTool : NSObject

#pragma mark - 播放音乐
/** 播放音乐 musicName : 音乐的名称 */
+ (void)playMusicWithName:(NSString *)musicName;
/** 暂停音乐 musicName : 音乐的名称 */
+ (void)pauseMusicWithName:(NSString *)musicName;
/** 停止音乐 musicName : 音乐的名称 */
+ (void)stopMusicWithName:(NSString *)musicName;

#pragma mark - 音效播放
/** 播放声音文件soundName : 音效文件的名称 */
+ (void)playSoundWithName:(NSString *)soundName;

@end
