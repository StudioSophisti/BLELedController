//
//  SSBLEController.h
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface SSBLEController : NSObject
{    
    CBUUID *ledServiceUUID;
    CBUUID *ledCharUUID;
}
@property (nonatomic,readonly) NSMutableArray *devices;

+ (SSBLEController*)instance;
- (void)sendColor:(UIColor*)color withSpeed:(unsigned char)speed;

@end
