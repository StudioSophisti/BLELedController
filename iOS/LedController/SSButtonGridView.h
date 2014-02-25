//
//  SSButtonGridView.h
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSButtonGridView : UIView

@property (nonatomic, readonly) NSMutableArray *buttonArray;

+ (NSArray*)colors;

@end
