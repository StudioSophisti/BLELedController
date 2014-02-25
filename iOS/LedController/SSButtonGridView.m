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
                    [UIColor colorWithRed:000.0f/255.0f green:000.0f/255.0f blue:000.0f/255.0f alpha:1.0f], //off
                    [UIColor colorWithRed:255.0f/255.0f green:000.0f/255.0f blue:000.0f/255.0f alpha:1.0f], //red
                    [UIColor colorWithRed:255.5f/255.0f green:127.5f/255.0f blue:000.0f/255.0f alpha:1.0f], //orange
                    
                    [UIColor colorWithRed:000.0f/255.0f green:000.0f/255.0f blue:255.0f/255.0f alpha:1.0f], //blue
                    [UIColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f], //cyan
                    [UIColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f], //green
                    
                    [UIColor colorWithRed:127.0f/255.0f green:000.0f/255.0f blue:225.0f/255.0f alpha:1.0f], //purple
                    [UIColor colorWithRed:255.0f/255.0f green:000.0f/255.0f blue:255.0f/255.0f alpha:1.0f], //magenta
                    [UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:225.0f/255.0f alpha:1.0f], //pink
                    
                    [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f], //white
                    [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:127.0f/255.0f alpha:1.0f], //warm white
                    [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f], //yellow
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
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_buttonArray addObject:btn];
    }
}

- (void)layoutSubviews {
    NSInteger btnCount = [[SSButtonGridView colors] count];
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
    
    [[SSBLEController instance] sendColor:sender.backgroundColor withSpeed:0x00];
}

@end
