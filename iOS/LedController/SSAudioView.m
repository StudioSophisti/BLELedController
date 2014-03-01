//
//  SSAudioView.m
//  LedRemote
//
//  Created by Tijn Kooijmans on 01/03/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSAudioView.h"
#import "SSBLEController.h"

static NSArray *__colors = nil;

@implementation SSAudioView

+ (NSArray*)colors {
    if (!__colors) {
        __colors = [NSArray arrayWithObjects:
                    SS_COLOR_PINK,
                    SS_COLOR_LIGHT_BLUE,
                    SS_COLOR_ORANGE,
                    SS_COLOR_LIGHT_GREEN,
                    SS_COLOR_YELLOW,
                    SS_COLOR_BLUE,
                    SS_COLOR_GREEN,
                    SS_COLOR_RED,
                    SS_COLOR_PURPLE,
                    nil];
    }
    return __colors;
}

- (void)awakeFromNib {
    powerView = [[UIView alloc] initWithFrame:CGRectZero];
    powerView.backgroundColor = [[SSAudioView colors] objectAtIndex:0];
    [self addSubview:powerView];
    
    thresholdView = [[UIView alloc] initWithFrame:CGRectZero];
    thresholdView.backgroundColor = [UIColor blackColor];
    [self addSubview:thresholdView];
    
    _thresHold = 0.5;
}

- (void)setInputPower:(float)inputPower {
    _previousInputPower = _inputPower;
    _inputPower = inputPower;
    
    if (_previousInputPower < _thresHold && _inputPower > _thresHold) {
        //change color
        colorIndex++;
        if (colorIndex == [[SSAudioView colors] count]) colorIndex = 0;
        powerView.backgroundColor = [[SSAudioView colors] objectAtIndex:colorIndex];
        
        [[SSBLEController instance] sendColor:powerView.backgroundColor withSpeed:0xFF];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    float height = self.frame.size.height * _inputPower;
    float peakHeight = self.frame.size.height * _thresHold;
    
    powerView.frame = CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height);
    thresholdView.frame = CGRectMake(0, self.frame.size.height - peakHeight, self.frame.size.width, 2);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    float y = [[touches anyObject] locationInView:self].y;
    
    _thresHold = (self.frame.size.height - y) / self.frame.size.height;
    
    [self setNeedsLayout];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    float y = [[touches anyObject] locationInView:self].y;
    
    _thresHold = (self.frame.size.height - y) / self.frame.size.height;
    
    [self setNeedsLayout];
}

@end
