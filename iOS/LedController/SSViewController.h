//
//  SSViewController.h
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSAnimationButtonGridView;
@class SSButtonGridView;

@interface SSViewController : UIViewController
{
    IBOutlet SSAnimationButtonGridView *effectAnimationGrid;
    IBOutlet SSAnimationButtonGridView *emotionAnimationGrid;
    IBOutlet SSAnimationButtonGridView *characterAnimationGrid;
    IBOutlet SSButtonGridView *colorGrid;
}
@end
