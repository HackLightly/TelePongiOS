//
//  ViewController.h
//  TableTennisHack
//
//  Created by Hicham Abou Jaoude on 1/24/2014.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *yRes;
    IBOutlet UILabel *score;
}
@property (nonatomic) int p1S;
@property (nonatomic) int p2S;
@property (nonatomic) int meS;
@end
