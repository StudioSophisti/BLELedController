//
//  SSColorButtonView.m
//  LedController
//
//  Created by Tijn Kooijmans on 27/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSColorButtonView.h"
#import "SSBLEController.h"

@implementation SSColorButtonView

- (void)sendColorWithSpeed:(unsigned char)speed {
    
    [[SSBLEController instance] sendColor:self.backgroundColor withSpeed:speed];
}

- (void)handleTouchEndAt:(CGPoint)endPoint {
    float distance = abs(touchPointStart.x - endPoint.x);
    int speed = 0xff;
    if (distance > 20) {
        speed = distance / self.frame.size.width * 0xff;
        speed = 0xff - MIN(speed, 0xff);
    }
    [self sendColorWithSpeed:(unsigned char)speed];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchPointStart = [[touches anyObject] locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEndAt:[[touches anyObject] locationInView:self]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEndAt:[[touches anyObject] locationInView:self]];
}

@end
