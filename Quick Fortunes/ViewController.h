//
//  ViewController.h
//  Quick Fortunes
//
//  Created by Patrick Serrano on 11/10/12.
//  Copyright (c) 2012 Patrick Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController {
    CFURLRef        soundFileURLRef;
    SystemSoundID   soundFileObject;
}

@property (readwrite) CFURLRef soundFileURLRef;
@property (readonly) SystemSoundID soundFileObject;
@property (weak, nonatomic) IBOutlet UILabel *predictionLabel;
@property (strong, nonatomic) NSArray *predictionArray;

- (void)makePrediction;

@end
