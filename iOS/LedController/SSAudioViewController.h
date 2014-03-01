//
//  SSAudioViewController.h
//  LedRemote
//
//  Created by Tijn Kooijmans on 01/03/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@class SSAudioView;

@interface SSAudioViewController : UIViewController
{
    AVAudioRecorder *recorder;
	NSTimer *levelTimer;
    
    double lowPassResults;
    
    IBOutlet SSAudioView *audioView;
}
@end
