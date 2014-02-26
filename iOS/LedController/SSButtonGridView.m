//
//  SSButtonGridView.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSButtonGridView.h"
#import "SSBLEController.h"

static NSArray *__colors = nil;


@implementation SSButtonGridView

+ (NSArray*)colors {
    if (!__colors) {
        __colors = [NSArray arrayWithObjects:
                    [UIColor colorWithRed:1 green:1 blue:1 alpha:1], //white
                    [UIColor colorWithRed:1 green:1 blue:0.5 alpha:1], //warm yellow
                    [UIColor colorWithRed:1 green:1 blue:0 alpha:1], //yellow
                    [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1], //orange
                    [UIColor colorWithRed:1 green:0 blue:0 alpha:1], //red
                    [UIColor colorWithRed:1 green:0 blue:0.5 alpha:1], //pink
                    [UIColor colorWithRed:0.5 green:0 blue:1 alpha:1], //purple
                    [UIColor colorWithRed:0 green:0 blue:1 alpha:1], //blue
                    [UIColor colorWithRed:0 green:1 blue:1 alpha:1], //light blue
                    [UIColor colorWithRed:0.5 green:1 blue:0 alpha:1], //light green
                    [UIColor colorWithRed:0 green:1 blue:0 alpha:1], //green
                    [UIColor colorWithRed:0 green:0 blue:0 alpha:1], //off
                    nil];
    }
    return __colors;
}


- (void)awakeFromNib {
    
    [SSBLEController instance];
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:[[SSButtonGridView colors] count]];
    
    for (UIColor *color in [SSButtonGridView colors]) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        [btn setBackgroundColor:color];
        [btn addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonSlide:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:btn];
        [_buttonArray addObject:btn];
    }
}

- (void)layoutSubviews {
    NSInteger btnCount = [[SSButtonGridView colors] count];
    //float columns = floor(sqrt(btnCount));
    float columns = 1;
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

- (void)buttonUp:(UIButton*)sender {
    
    if (lastButton != sender)
        [[SSBLEController instance] sendColor:sender.backgroundColor withSpeed:0xFF];
    
    lastButton = nil;
}

- (void)buttonSlide:(UIButton*)sender {
    
    [[SSBLEController instance] sendColor:sender.backgroundColor withSpeed:0x00];
    
    lastButton = sender;
}

@end
