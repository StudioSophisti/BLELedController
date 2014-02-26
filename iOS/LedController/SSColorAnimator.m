//
//  SSColorAnimator.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSColorAnimator.h"
#import "SSBLEController.h"

@implementation SSColorAnimator

+ (SSColorAnimator*)animatorWithSequence:(NSArray*)sequence name:(NSString*)animationName loops:(int)loopCount {
    SSColorAnimator *ani = [[SSColorAnimator alloc] init];
    ani.sequence = sequence;
    ani.loopCount = loopCount;
    ani.animationName = animationName;
    return ani;
}

- (void)play {
    animationIndex = 0;
    currentLoop = 0;
    isStopped = NO;
    
    [self next];
}

- (void)next {
    if (!isStopped && animationIndex < [_sequence count]) {
        
        SSSeqStep *step = [_sequence objectAtIndex:animationIndex];
        
        float time;
        
        if (step.durationMin == step.durationMax) {
            time = step.durationMax;
        } else {
            time = step.durationMin + ((float)arc4random() / UINT_MAX) * (step.durationMax - step.durationMin);
        }
        
        [[SSBLEController instance] sendColor:step.color withSpeed:step.transitionSpeed];
        
        animationIndex++;
        
        [self performSelector:@selector(next) withObject:nil afterDelay:time];
        
        
    } else if (animationIndex >= [_sequence count] && currentLoop < _loopCount) {
        currentLoop++;
        animationIndex = 0;
        [self next];
    }
}

- (void)stop {
    isStopped = YES;
}

@end

@implementation SSSeqStep

+ (SSSeqStep*)stepWithColor:(UIColor*)color min:(float)durationMin max:(float)durationMax speed:(unsigned char)transitionSpeed {
    SSSeqStep *step = [[SSSeqStep alloc] init];
    step.color = color;
    step.durationMin = durationMin;
    step.durationMax = durationMax;
    step.transitionSpeed = transitionSpeed;
    return step;
}

@end