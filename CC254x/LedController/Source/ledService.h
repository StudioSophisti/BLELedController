
#ifndef SWTIMESERVICE_H
#define SWTIMESERVICE_H

#ifdef __cplusplus
extern "C"
{
#endif

/*********************************************************************
 * INCLUDES
 */

#include "hal_types.h"
  
#define LED_SERVICE_UUID                    0xFA01   
#define LED_DATA_CHAR_UUID                  0xFB01   
      
// Length of Characteristics in bytes
#define LED_DATA_CHAR_LEN                   6  

extern bStatus_t LedService_AddService( void );

/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* SWTIMESERVICE_H */
