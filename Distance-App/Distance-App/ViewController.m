//
//  ViewController.m
//  Distance-App
//
//  Created by Avisa Poshtkouhi on 7/18/20.
//  Copyright © 2020 Avisa Poshtkouhi. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()
@property (nonatomic) DGDistanceRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *startLoaction;
@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;
@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UITextField *endLocationC;

@end

@implementation ViewController
- (IBAction)calculateButtonTapped:(id)sender {
    
  self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLoaction.text;
    NSString *destA = self.distanceA.text;
    NSString *destB = self.distanceB.text;
    NSString *destC = self.distanceC.text;
    NSArray *dests = @[destA, destB, destC];
    
    __weak ViewController *weakSelf = self;
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    self.req.callback = ^(NSArray *response) {
        
        ViewController *strongSelf = weakSelf;
        strongSelf.distanceC.text = @"CallBack";
        strongSelf.calculateButton.enabled = YES;
        strongSelf.req = nil;
    };
    
    [self.req start];
}

@end
