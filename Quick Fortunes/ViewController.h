//
//  ViewController.h
//  Quick Fortunes
//
//  Created by Patrick Serrano on 11/10/12.
//  Copyright (c) 2012 Patrick Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *predictionLabel;
@property (strong, nonatomic) NSArray *predictionArray;

- (void)makePrediction;

@end
