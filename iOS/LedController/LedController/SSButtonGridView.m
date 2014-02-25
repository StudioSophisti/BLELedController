//
//  SSButtonGridView.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSButtonGridView.h"

static NSArray *__colors = nil;


@implementation SSButtonGridView

+ (NSArray*)colors {
    if (!__colors) {
        __colors = [NSArray arrayWithObjects:
                    [UIColor colorWithRed:255.0f/255.0f green:000.0f/255.0f blue:000.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:000.0f/255.0f green:000.0f/255.0f blue:255.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:000.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:000.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:000.0f/255.0f blue:255.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:225.0f/255.0f blue:225.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f],
                    [UIColor colorWithRed:255.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0f],
                    nil];
    }
    return __colors;
}


- (void)awakeFromNib {
    
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
    float columns = sqrt(btnCount);
    float rows = ceil(btnCount/columns);
    
    float btnWidth = self.frame.size.width / columns;
    float btnHeight = self.frame.size.height / rows;
    
    int index = 0;
    for (UIButton *btn in _buttonArray) {
        float x = (index % (int)columns) * btnWidth;
        float y = floor(index / rows) * btnHeight;
        btn.frame = CGRectMake(x, y, btnWidth, btnHeight);
        index ++;
    }
}

- (void)buttonPressed:(UIButton*)sender {
    NSLog([sender.backgroundColor description]);
}

@end
