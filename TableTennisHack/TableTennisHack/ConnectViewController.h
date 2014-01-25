//
//  ConnectViewController.h
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
@interface ConnectViewController : UIViewController <SocketIODelegate>
{
SocketIO *socketIO;
    NSTimer *timerCheck;
    IBOutlet UILabel *tableTenLabel;
    IBOutlet UILabel *scanCode;
    IBOutlet UIButton *scanButt;
    IBOutlet UIButton *aboutButt;
    IBOutlet UILabel *designBy;
}
@end
