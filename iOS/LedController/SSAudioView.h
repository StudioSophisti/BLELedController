//
//  SSAudioView.h
//  LedRemote
//
//  Created by Tijn Kooijmans on 01/03/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSAudioView : UIView
{
    UIView *powerView;
    UIView *thresholdView;
    
    int colorIndex;
    
}

@property (nonatomic, assign) float inputPower;
@property (nonatomic, assign) float previousInputPower;
@property (nonatomic, assign) float thresHold;
@end
