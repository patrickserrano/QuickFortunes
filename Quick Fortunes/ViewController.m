//
//  ViewController.m
//  Quick Fortunes
//
//  Created by Patrick Serrano on 11/10/12.
//  Copyright (c) 2012 Patrick Serrano. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize predictionArray,soundFileObject,soundFileURLRef;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        UIImage *image = [UIImage imageNamed:@"background-568h"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.view insertSubview:imageView atIndex:0];
    } else {
        UIImage *image = [UIImage imageNamed:@"background"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.view insertSubview:imageView atIndex:0];
    }
    
    
    
    self.predictionArray = [[NSArray alloc] initWithObjects:
                            @"It is certain",
                            @"Not Likely",
                            @"Yes",
                            @"Murky, try again later",
                            @"Of course",
                            @"It is unknown",
                            @"It cannot be known",
                            @"The stars are aligned",
                            @"Ask again",
                            @"Absolutely",
                            @"Cloudy",
                            @"Ask tomorrow",
                            @"Check back later",nil];
    
    NSURL *fx = [[NSBundle mainBundle] URLForResource:@"sfx"
                                        withExtension:@"caf"];
    
    self.soundFileURLRef = (__bridge CFURLRef) fx;
    
    AudioServicesCreateSystemSoundID(
                                     
        soundFileURLRef,
        &soundFileObject
    );
}

- (void)makePrediction {
    NSUInteger index = arc4random_uniform(self.predictionArray.count);
    
    self.predictionLabel.text = [self.predictionArray objectAtIndex:index];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    self.predictionLabel.text = @"";
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        AudioServicesPlaySystemSound(soundFileObject);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5f];
        
        self.predictionLabel.alpha = 0.0f;
        
        [UIView commitAnimations];
        
        [self makePrediction];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5f];
        
        self.predictionLabel.alpha = 1.0f;
        
        [UIView commitAnimations];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5f];
        
        self.predictionLabel.alpha = 0.0f;
        
        [UIView commitAnimations];
        
        [self makePrediction];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5f];
        
        self.predictionLabel.alpha = 1.0f;
        
        [UIView commitAnimations];
    }
    NSLog(@"Canceled");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    
    self.predictionLabel.alpha = 0.0f;
    
    [UIView commitAnimations];
    
    self.predictionLabel.text = @"";
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self makePrediction];
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    
    self.predictionLabel.alpha = 1.0f;
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
