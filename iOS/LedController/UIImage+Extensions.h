//
//  UIImage+Extensions.h
//  LegoSmartBrick
//
//  Created by Tijn Kooijmans on 20-08-13.
//  Copyright (c) 2013 Studio Sophisti. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//  UIImage-Extensions.h
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface UIImage (Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)fixOrientation;
- (UIImage *)normalizedImage;

@end;