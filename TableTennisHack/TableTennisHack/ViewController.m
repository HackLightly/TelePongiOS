//
//  ViewController.m
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Numz: %d, %d, %d ", self.p1S, self.p2S, self.meS);
        if (self.p1S > self.p2S)
        {
            if (self.meS == 1)
            {
               yRes.text = @"You Won!";
            }else{
                yRes.text = @"You Lost!";
            }
            score.text = [NSString stringWithFormat:@"Score: %d - %d", self.p1S, self.p2S];
        }
        else if (self.p1S < self.p2S)
        {
            if (self.meS == 2)
            {
                yRes.text = @"You Won!";
            }
            else{
                yRes.text = @"You Lost!";
            }
            score.text = [NSString stringWithFormat:@"Score: %d - %d", self.p2S, self.p1S];
        }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotate
{
    
    return NO;
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
@end
