//
//  SSColorAnimator.h
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSColorAnimator : NSObject
{
    BOOL isStopped;
    int animationIndex;
    int currentLoop;
}
@property (nonatomic, strong) NSArray *sequence;
@property (nonatomic, copy) NSString *animationName;
@property (nonatomic, assign) int loopCount;

+ (SSColorAnimator*)animatorWithSequence:(NSArray*)sequence name:(NSString*)animationName loops:(int)loopCount;

- (void)play;
- (void)stop;

@end


@interface SSSeqStep : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) float durationMin;
@property (nonatomic, assign) float durationMax;
@property (nonatomic, assign) unsigned char transitionSpeed;

+ (SSSeqStep*)stepWithColor:(UIColor*)color min:(float)durationMin max:(float)durationMax speed:(unsigned char)transitionSpeed;

@end