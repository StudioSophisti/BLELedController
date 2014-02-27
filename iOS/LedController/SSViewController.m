//
//  SSViewController.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSViewController.h"
#import "SSColorAnimator.h"
#import "SSAnimationButtonGridView.h"
#import "SSButtonGridView.h"

static NSArray *__effects = nil;
static NSArray *__emotions = nil;
static NSArray *__characters = nil;

@interface SSViewController ()

@end

@implementation SSViewController

+ (NSArray*)effects {
    if (!__effects) {
        __effects = [NSArray arrayWithObjects:
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_WHITE min:0.1 max:0.2 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.3 max:0.6 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WHITE min:0.1 max:0.2 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.1 max:0.2 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WHITE min:0.1 max:0.2 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:1.0 max:2.0 speed:0xFF], nil]
                                                      name:@"lightning-icon" loops:2],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_DARK_ORANGE min:0.2 max:0.7 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_ORANGE min:0.2 max:0.7 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_DARK_ORANGE min:0.1 max:0.3 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_ORANGE min:0.1 max:0.3 speed:0xFF], nil]
                                                      name:@"fire-icon" loops:5],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:1 max:1 speed:0x010],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WHITE min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_YELLOW min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_ORANGE min:0.3 max:0.3 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:1 max:1 speed:0x02], nil]
                                                      name:@"explosion-icon" loops:1],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_LIGHT_BLUE min:0.7 max:1.5 speed:0x02],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.7 max:1.5 speed:0x02], nil]
                                                      name:@"water-icon" loops:5],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_WHITE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_GREEN min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WARM_WHITE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_YELLOW min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_LIGHT_GREEN min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_RED min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_ORANGE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_LIGHT_BLUE min:0.5 max:0.5 speed:0x10], nil]
                                                      name:@"disco-icon" loops:1],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_RED min:0.7 max:1.5 speed:0x02],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.7 max:1.5 speed:0x02], nil]
                                                      name:@"hearth-icon" loops:5],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_OFF min:1 max:1 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_DARK_ORANGE min:2.5 max:2.5 speed:0x01],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WARM_WHITE min:2.5 max:2.5 speed:0x01], nil]
                                                      name:@"sunrise-icon" loops:1],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.25 max:0.25 speed:0x20],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.25 max:0.25 speed:0x20],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.5 max:0.5 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.25 max:0.25 speed:0x20],
                                                             [SSSeqStep stepWithColor:SS_COLOR_LIGHT_BLUE min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_LIGHT_BLUE min:0.1 max:0.1 speed:0xFF],
                                                             [SSSeqStep stepWithColor:SS_COLOR_BLUE min:0.25 max:0.25 speed:0x20],
                                                             [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.5 max:0.5 speed:0x10], nil]
                                                      name:@"magic-icon" loops:2],
                     
                     [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                             [SSSeqStep stepWithColor:SS_COLOR_WARM_WHITE min:0.4 max:0.4 speed:0x10],
                                                             [SSSeqStep stepWithColor:SS_COLOR_DIM_WHITE min:0.1 max:0.1 speed:0x78],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WARM_WHITE min:0.1 max:0.1 speed:0x78],
                                                             [SSSeqStep stepWithColor:SS_COLOR_DIM_WHITE min:0.1 max:0.1 speed:0x78],
                                                             [SSSeqStep stepWithColor:SS_COLOR_WARM_WHITE min:0.3 max:0.3 speed:0x05], nil]
                                                      name:@"hearthbeat-icon" loops:5],
                     nil];
    }
    return __effects;
}

+ (NSArray*)emotions {
    if (!__emotions) {
        __emotions = [NSArray arrayWithObjects:
                      [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.25 max:0.25 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.16 max:0.16 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.25 max:0.25 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.16 max:0.16 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.25 max:0.25 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.16 max:0.16 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.25 max:0.25 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.16 max:0.16 speed:0xFF], nil]
                                                       name:@"anger-icon" loops:1],
                      
                      [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.1 max:0.1 speed:0x20],
                                                              [SSSeqStep stepWithColor:SS_COLOR_GREEN min:0.5 max:0.5 speed:0x05],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.2 max:0.2 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_GREEN min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.2 max:0.2 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_GREEN min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.8 max:0.8 speed:0xFF], nil]
                                                       name:@"fear-icon" loops:2],
                      
                    [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.33 max:0.33 speed:0x10],
                                                                [SSSeqStep stepWithColor:SS_COLOR_GREEN min:0.25 max:0.25 speed:0x10],
                                                                [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.33 max:0.33 speed:0x10],
                                                                [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.25 max:0.25 speed:0x10],
                                                                [SSSeqStep stepWithColor:SS_COLOR_OFF min:1 max:1 speed:0xFF], nil]
                                                       name:@"disgust-icon" loops:1],
                      
                      [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.4 max:0.4 speed:0x10],
                                                              [SSSeqStep stepWithColor:SS_COLOR_DIM_YELLOW min:0.75 max:0.75 speed:0x08],
                                                              [SSSeqStep stepWithColor:SS_COLOR_DIM_YELLOW2 min:0.5 max:0.5 speed:0x10],
                                                              [SSSeqStep stepWithColor:SS_COLOR_YELLOW min:0.25 max:0.25 speed:0x20], nil]
                                                       name:@"happy-icon" loops:1],
                     
                      [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                              [SSSeqStep stepWithColor:SS_COLOR_LIGHT_BLUE min:0.4 max:0.4 speed:0x10],
                                                              [SSSeqStep stepWithColor:SS_COLOR_BLUE min:2 max:2 speed:0x01],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:2 max:2 speed:0x01], nil]
                                                      name:@"sadness-icon" loops:1],
                      
                      [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                              [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_RED min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_PINK min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:0.1 max:0.1 speed:0xFF],
                                                              [SSSeqStep stepWithColor:SS_COLOR_OFF min:0.5 max:0.5 speed:0xFF], nil]
                                                       name:@"surprice-icon" loops:1],
                     
                     nil];
    }
    return __emotions;
}

+ (NSArray*)characters {
    if (!__characters) {
        __characters = [NSArray arrayWithObjects:
                      
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:SS_COLOR_GREEN min:1 max:1 speed:0x10], nil]
                                                       name:@"1-icon" loops:1],
                      
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:SS_COLOR_PURPLE min:1 max:1 speed:0x10], nil]
                                                       name:@"2-icon" loops:1],
                        
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:SS_COLOR_ORANGE min:1 max:1 speed:0x10], nil]
                                                         name:@"3-icon" loops:1],
                      
                      nil];
    }
    return __characters;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    emotionAnimationGrid.animations = [SSViewController emotions];
    effectAnimationGrid.animations = [SSViewController effects];
    characterAnimationGrid.animations = [SSViewController characters];
    
    colorGrid.layer.cornerRadius = 8;
    colorGrid.layer.borderColor = [UIColor blackColor].CGColor;
    colorGrid.layer.borderWidth = 2;
    colorGrid.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
