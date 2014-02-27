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
#import "UIImage+Extensions.h"

@implementation SSAnimationButtonGridView

- (void)setAnimations:(NSArray *)animations {
    
    _animations = animations;
    
    [SSBLEController instance];
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:[animations count]];
    
    for (SSColorAnimator *ani in animations) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        btn.contentMode = UIViewContentModeScaleAspectFit;
        
        if (IS_IPAD) {
             [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", ani.animationName]] forState:UIControlStateNormal];
        } else {
             [btn setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", ani.animationName]] imageByScalingProportionallyToSize:CGSizeMake(67, 67)] forState:UIControlStateNormal];
        }
       
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        [_buttonArray addObject:btn];
    }
}

- (void)layoutSubviews {
    NSInteger btnCount = [_animations count];
    //float columns = floor(sqrt(btnCount));
    float columns = 3;
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
    
    SSColorAnimator *ani = [_animations objectAtIndex:[_buttonArray indexOfObject:sender]];
    
    if (_lastAnimator) [_lastAnimator stop];
    _lastAnimator = ani;
    
    [ani play];
    
}

@end
