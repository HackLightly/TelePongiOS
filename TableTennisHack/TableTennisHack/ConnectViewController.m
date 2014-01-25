//
//  ConnectViewController.m
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import "ConnectViewController.h"
#import "ZBarSDK.h"
#import "SocketIOPacket.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "GameViewController.h"
@interface ConnectViewController () < ZBarReaderDelegate >
{
    UIImageView *resultImage;
    UITextView *resultText;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
- (IBAction) scanButtonTapped;
@end

@implementation ConnectViewController


- (void) dealloc
{
    self.resultImage = nil;
    self.resultText = nil;
   // [super dealloc];
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return(YES);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(BOOL)shouldAutorotate
{
    
    return NO;
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toGame"]) {
        [[segue destinationViewController] setIDNumber:idNum];
    }
}
NSString *idNum = @"";
int perf = 0;
-(void)performStuff
{
    [self performSegueWithIdentifier:@"toGame" sender:self];
         [timerCheck invalidate];
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
    idNum = symbol.data;
    
    
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
    [self performSelector:@selector(performStuff) withObject:nil afterDelay:1];
    
}
- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
    //[reader release];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    UIFont *customFont = [UIFont fontWithName:@"Nunito-Light" size:49.0f];
    // tableTenLabel.font = customFont;
    [tableTenLabel setFont:customFont];
    UIFont *customFont2 = [UIFont fontWithName:@"Nunito-Light" size:17.0f];
    // tableTenLabel.font = customFont;
    [scanCode setFont:customFont2];
    UIFont *customFont3 = [UIFont fontWithName:@"Nunito-Light" size:15.0f];
      [scanButt setFont:customFont3];
      [aboutButt setFont:customFont3];
     UIFont *customFont4 = [UIFont fontWithName:@"Nunito-Light" size:12.0f];
    [designBy setFont:customFont4];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
