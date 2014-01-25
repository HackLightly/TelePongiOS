//
//  GameViewController.h
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import <AVFoundation/AVAudioPlayer.h>
@interface GameViewController : UIViewController <SocketIODelegate>
{
    SocketIO *socketIO;
    AVAudioPlayer *audioPlayer;
}
@property (strong, nonatomic) NSString *iDNumber;
@end
