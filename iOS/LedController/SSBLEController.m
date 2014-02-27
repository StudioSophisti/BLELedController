//
//  SSBLEController.m
//  LedController
//
//  Created by Tijn Kooijmans on 25/02/14.
//  Copyright (c) 2014 Studio Sophisti. All rights reserved.
//

#import "SSBLEController.h"
#import "LGBluetooth.h"
#import "CBUUID+StringExtraction.h"
#import "SSColorAnimator.h"

#define LED_SERVICE_UUID       @"3F29121C-FA01-000A-0001-000000000000"
#define LED_CHAR_UUID          @"3F29121C-FB01-000A-0001-000000000000"

static SSBLEController *__instance = nil;

@implementation SSBLEController

+ (SSBLEController*)instance {
    if (!__instance) {
        __instance = [[SSBLEController alloc] init];
    }
    
    return __instance;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    if ((self = [super init])) {
        _devices = [[NSMutableArray alloc] initWithCapacity:20];
            
        ledServiceUUID = [CBUUID UUIDWithString:LED_SERVICE_UUID];
        ledCharUUID = [CBUUID UUIDWithString:LED_CHAR_UUID];
        
        [self startScanning];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peripheralDidDisconnect:) name:kLGPeripheralDidDisconnect object:nil];
        
    }
    
    return  self;
}

- (void)setCurrentAnimator:(SSColorAnimator *)currentAnimator {
    if (_currentAnimator) {
        [_currentAnimator stop];
    }
    
    _currentAnimator = currentAnimator;
}

- (void)sendColor:(UIColor*)color withSpeed:(unsigned char)speed {
    
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:NULL];
    
    NSLog(@"Setting color %.1f %.1f %.1f with speed %d", red, green, blue, speed);
    
    red = red * 255.0f;
    green = green * 255.0f;
    blue = blue * 255.0f;
    
    unsigned char bytes[] = {(unsigned char)red, speed, (unsigned char)green, speed, (unsigned char)blue, speed};
    NSMutableData *colorData = [NSMutableData dataWithBytes:bytes length:6];
    
    for (LGPeripheral *peripheral in _devices) {
        
        //search the Led characteristic
        for (LGService *service in peripheral.services) {
            if ([service.UUIDString isEqualToString:[ledServiceUUID representativeString]]) {
                for (LGCharacteristic *charac in service.characteristics) {
                    if ([charac.UUIDString isEqualToString:[ledCharUUID representativeString]]) {
                        [charac writeValue:colorData completion:nil];
                    }
                }
            }
        }
    }
}

- (void)peripheralDidDisconnect:(id)sender {
    [_devices removeObject:sender];
    
    [self startScanning];
}

- (void)startScanning {
    
    NSArray	*uuidArray = [NSArray arrayWithObjects:ledServiceUUID, nil];
    
    if ([LGCentralManager sharedInstance].isCentralReady) {
        [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:3
                                                               services:uuidArray
                                                                options:nil
                                                             completion:^(NSArray *peripherals) {
                                                                 for (LGPeripheral *peripheral in peripherals) {
                                                                     [self connectAndDiscoverPeripheral:peripheral];
                                                                 }
                                                                 [self performSelector:@selector(startScanning) withObject:nil afterDelay:1.0f];
                                                                 
                                                             }
         ];
    } else {
        
        [self performSelector:@selector(startScanning) withObject:nil afterDelay:3.0f];
    }
    
    
}

- (void)connectAndDiscoverPeripheral:(LGPeripheral *)peripheral {
    
    NSArray	*uuidArray = [NSArray arrayWithObjects:ledServiceUUID, nil];
    
    // First of all, opening connection
    [peripheral connectWithTimeout:10
                        completion:^(NSError *error) {
     
        // Discovering services of peripheral
        [peripheral discoverServices:uuidArray
                          completion:^(NSArray *services, NSError *error) {
            
            for (LGService *service in services) {
                
                // Discovering characteristics of Led service
                [service discoverCharacteristicsWithCompletion:^(NSArray *characteristics, NSError *error) {
                    
                    // Searching Led characteristic
                    for (LGCharacteristic *charact in characteristics) {
                        
                        if ([charact.UUIDString isEqualToString:[ledCharUUID representativeString]]) {
                            [_devices addObject:peripheral];
                        }
                    }
                    
                }];
            }
        }];
    }];
}


@end
