//
//  SSAudioViewController.m
//  LedRemote
//
//  Created by Tijn Kooijmans on 01/03/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSAudioViewController.h"
#import "SSAudioView.h"

@interface SSAudioViewController ()

@end

@implementation SSAudioViewController

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
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    if ([session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError]) {
   
        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
        
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                  nil];
        
        NSError *error;
        
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (recorder) {
            [recorder prepareToRecord];
            recorder.meteringEnabled = YES;
            [recorder record];
            
            levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
            
        } else
            NSLog(@"%@", [error description]);
    }
    
}

- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    
 	double normalizedPower = pow(10, (0.05 * [recorder averagePowerForChannel:0])) * 2;

    audioView.inputPower = normalizedPower;
}

@end
