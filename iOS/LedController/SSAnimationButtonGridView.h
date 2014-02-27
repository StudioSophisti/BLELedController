//
//  SSButtonGridView.h
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSColorAnimator;

@interface SSAnimationButtonGridView : UIView

@property (nonatomic, strong) NSArray *animations;
@property (nonatomic, readonly) SSColorAnimator *lastAnimator;
@property (nonatomic, readonly) NSMutableArray *buttonArray;

@end
