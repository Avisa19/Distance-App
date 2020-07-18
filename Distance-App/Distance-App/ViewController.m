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
    
    // Allocate Memory heap
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.startLoaction.text;
    NSString *destA = self.distanceA.text;
    NSString *destB = self.distanceB.text;
    NSString *destC = self.distanceC.text;
    NSArray *dests = @[destA, destB, destC];
    
    __weak ViewController *weakSelf = self;
    // Initialze it
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    // Create a callback
    self.req.callback = ^(NSArray *response) {
        
        ViewController *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        if ([NSNull null] != response[0]) {
            strongSelf.distanceA.text = [NSString stringWithFormat: @"%.2f km", [response[0] floatValue]];
        } else {
            strongSelf.distanceA.text = @"?";
        }
        
      
        strongSelf.calculateButton.enabled = YES;
        strongSelf.req = nil;
    };
    
    // Activate it
    [self.req start];
}

@end
