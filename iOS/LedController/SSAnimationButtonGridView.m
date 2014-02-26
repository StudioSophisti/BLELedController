//
//  SSButtonGridView.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSAnimationButtonGridView.h"
#import "SSBLEController.h"
#import "SSColorAnimator.h"

static NSArray *__animations = nil;

@implementation SSAnimationButtonGridView

+ (NSArray*)animations {
    if (!__animations) {
        __animations = [NSArray arrayWithObjects:
                        
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:[UIColor redColor] min:0.2 max:0.2 speed:0xFF],
                                                                [SSSeqStep stepWithColor:[UIColor orangeColor] min:0.1 max:0.4 speed:0xFF],
                                                                [SSSeqStep stepWithColor:[UIColor redColor] min:0.2 max:0.2 speed:0xFF],
                                                                [SSSeqStep stepWithColor:[UIColor orangeColor] min:1.0 max:2.0 speed:0xFF], nil]
                                                         name:@"lighting" loops:HUGE_VAL],
                        
                        
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:[UIColor whiteColor] min:0.2 max:0.2 speed:0xFF],
                                                                [SSSeqStep stepWithColor:[UIColor whiteColor] min:0.2 max:0.2 speed:0xFF], nil]
                                                         name:@"fire" loops:HUGE_VAL],
                        
                        
                        [SSColorAnimator animatorWithSequence: [NSArray arrayWithObjects:
                                                                [SSSeqStep stepWithColor:[UIColor whiteColor] min:0.2 max:0.2 speed:0xFF],
                                                                [SSSeqStep stepWithColor:[UIColor whiteColor] min:0.2 max:0.2 speed:0xFF], nil]
                                                         name:@"water" loops:HUGE_VAL],
                        
                    nil];
    }
    return __animations;
}


- (void)awakeFromNib {
    
    [SSBLEController instance];
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:[[SSAnimationButtonGridView animations] count]];
    
    for (SSColorAnimator *ani in [SSAnimationButtonGridView animations]) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        [btn setTitle:ani.animationName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        [_buttonArray addObject:btn];
    }
}

- (void)layoutSubviews {
    NSInteger btnCount = [[SSAnimationButtonGridView animations] count];
    float columns = floor(sqrt(btnCount));
    float rows = ceil(btnCount/columns);
    
    float btnWidth = self.frame.size.width / columns;
    float btnHeight = self.frame.size.height / rows;
    
    int index = 0;
    for (UIButton *btn in _buttonArray) {
        float x = (index % (int)columns) * btnWidth;
        float y = floor(index / columns) * btnHeight;
        btn.frame = CGRectMake(x, y, btnWidth, btnHeight);
        index ++;
    }
}

- (void)buttonPressed:(UIButton*)sender {
    
    SSColorAnimator *ani = [[SSAnimationButtonGridView animations] objectAtIndex:[_buttonArray indexOfObject:sender]];
    
    if (_lastAnimator) [_lastAnimator stop];
    _lastAnimator = ani;
    
    [ani play];
    
}

@end
