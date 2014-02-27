//
//  SSColorButtonView.m
//  LedController
//
//  Created by Tijn Kooijmans on 27/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSColorButtonView.h"
#import "SSBLEController.h"
#import "SSColorAnimator.h"

@implementation SSColorButtonView

- (id)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame]))
    {
        overlayView = [[UIView alloc] initWithFrame:CGRectZero];
        overlayView.userInteractionEnabled = NO;
        overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        overlayView.hidden = YES;
        [self addSubview: overlayView];
    }
    return self;
}

- (void)layoutSubviews {
    overlayView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)sendColorWithSpeed:(unsigned char)speed {
    
    [[SSBLEController instance].currentAnimator stop];
    
    [[SSBLEController instance] sendColor:self.backgroundColor withSpeed:speed];
}

- (void)handleTouchEndAt:(CGPoint)endPoint {

    overlayView.hidden = YES;

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

    overlayView.hidden = NO;

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEndAt:[[touches anyObject] locationInView:self]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouchEndAt:[[touches anyObject] locationInView:self]];
}

@end
