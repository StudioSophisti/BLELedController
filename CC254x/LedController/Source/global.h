#ifndef GLOBAL_H
#define GLOBAL_H

// Base 128-bit UUID: 3F29121C-XXXX-000A-0001-000000000000
#define BASE_UUID_128( uuid )  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, \
        0x0A, 0x00, LO_UINT16( uuid ), HI_UINT16( uuid ), 0x1C, 0x12, 0x29, 0x3F
                                    
                                    
#endif //GLOBAL_H