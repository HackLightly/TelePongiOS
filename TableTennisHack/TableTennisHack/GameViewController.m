//
//  GameViewController.m
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import "GameViewController.h"
#import "SocketIOPacket.h"
#import <AudioToolbox/AudioServices.h>
#import <CoreMotion/CoreMotion.h>
@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    [socketIO connectToHost:@"vast-woodland-7556.herokuapp.com" onPort:0];
    [socketIO sendEvent:@"joinConnectionMobile" withData:self.iDNumber];
    NSLog(@"Id:%@",self.iDNumber);
}
-(BOOL)shouldAutorotate
{
    
    return NO;
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskLandscape;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    SocketIOCallback cb = ^(id argsData) {
        NSDictionary *response = argsData;
        NSLog(@"ack arrived: %@", response);
        
        [socketIO disconnectForced];
    };
    
    if ([packet.name isEqualToString:@"gameData" ])
    {
        
    }
    if ([packet.name isEqualToString:@"onHit" ]) {
        int player = [packet.args[0] integerValue];
        if (player == myPlay)
        {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
    }
    
}
int didHH = 0;
int myPlay = -1;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    NSLog(@"You Hit it");
    
    [socketIO sendEvent:@"swing" withData:self.iDNumber];
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES; }

- (void) viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
@end
