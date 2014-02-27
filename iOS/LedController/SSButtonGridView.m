//
//  SSButtonGridView.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSButtonGridView.h"
#import "SSBLEController.h"
#import "SSColorButtonView.h"

static NSArray *__colors = nil;


@implementation SSButtonGridView

+ (NSArray*)colors {
    if (!__colors) {
        __colors = [NSArray arrayWithObjects:
                    SS_COLOR_WHITE,
                    SS_COLOR_WARM_WHITE,
                    SS_COLOR_YELLOW,
                    SS_COLOR_ORANGE,
                    SS_COLOR_RED,
                    SS_COLOR_PINK,
                    SS_COLOR_PURPLE,
                    SS_COLOR_BLUE,
                    SS_COLOR_LIGHT_BLUE,
                    SS_COLOR_LIGHT_GREEN,
                    SS_COLOR_GREEN,
                    SS_COLOR_OFF,
                    nil];
    }
    return __colors;
}


- (void)awakeFromNib {
    
    [SSBLEController instance];
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:[[SSButtonGridView colors] count]];
    
    for (UIColor *color in [SSButtonGridView colors]) {
        SSColorButtonView *btn = [[SSColorButtonView alloc] initWithFrame:CGRectZero];
        [btn setBackgroundColor:color];
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
    for (SSColorButtonView *btn in _buttonArray) {
        float x = (index % (int)columns) * btnWidth;
        float y = floor(index / columns) * btnHeight;
        btn.frame = CGRectMake(x, y, btnWidth, btnHeight);
        index ++;
    }
}

@end
