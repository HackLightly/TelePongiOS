#import "GameViewController.h"
#import "SocketIOPacket.h"
#import <AudioToolbox/AudioServices.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "MBProgressHUD.h"

@interface GameViewController ()
{
     MBProgressHUD *hudupload;
}

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
    [socketIO connectToHost:@"telepong.herokuapp.com" onPort:0];
    NSString *idnumbz = self.iDNumber;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:idnumbz forKey:@"id"];
    [socketIO sendEvent:@"joinConnectionMobile" withData:dict];
    NSLog(@"Id:%@",self.iDNumber);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"swoosh"
                                         ofType:@"mp3"]];
    NSError *error;
     audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

}
-(BOOL)shouldAutorotate
{
    
    return NO;
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
    
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
    
    
    if ([packet.name isEqualToString:@"statusChange" ])
    {
        NSString *str = packet.args[0] ;
        NSLog(@"Stat:%@",str);
        int player = [str integerValue];
        if (player == 2)
        {
            myPlay = 1;
        } else if (player == 4)
        {
            [hudupload hide:YES];
            myPlay = 2;
            
        }
        else if (player == -1)
        {
            [socket disconnectForced];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else if (player == 11)
        {
             AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
             AudioServicesPlaySystemSound(1104);
            
            
        }
        else if (player == 10)
        {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1104);
            
            
        }
    }
    if ([packet.name isEqualToString:@"onHit" ]) {
        int player = [packet.args[0] integerValue];
        NSLog(@"ON HIT:%d",player);
        if (player == myPlay)
        {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        }
    }
    
}
int didHH = 0;
int myPlay = -5;
-(IBAction)buttonTest:(id)sender
{
    NSLog(@"!!!!!You Hit it");
    NSString *idnumbz = self.iDNumber;
    NSLog(@"!!!!!!went here");
    NSDictionary *dic = [NSDictionary dictionaryWithObject:idnumbz forKey:@"id"];
    [socketIO sendEvent:@"swing" withData:dic];
    // [audioPlayer play];
    NSLog(@"!!!!!!exi!t");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"!!!!!!!!!!!!entered");
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
    NSLog(@"!!!!!You Hit it");
    NSString *idnumbz = self.iDNumber;
        NSLog(@"!!!!!!went here");
    NSDictionary *dic = [NSDictionary dictionaryWithObject:idnumbz forKey:@"id"];
    [socketIO sendEvent:@"swing" withData:dic];
          [audioPlayer play];
        NSLog(@"!!!!!!exi!t");
    }

    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{ return YES; }

- (void) viewWillAppear:(BOOL)animated
{
    hudupload = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hudupload];
    hudupload.delegate = self;
    hudupload.mode = MBProgressHUDModeIndeterminate;
    hudupload.labelText = @"Waiting for Opponent";
    [hudupload show:YES];

    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
@end
