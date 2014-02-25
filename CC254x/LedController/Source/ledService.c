/*********************************************************************
 * INCLUDES
 */
#include "bcomdef.h"
#include "OSAL.h"
#include "linkdb.h"
#include "att.h"
#include "gatt.h"
#include "gatt_uuid.h"
#include "gattservapp.h"
#include "gapbondmgr.h"
#include "global.h"
#include "ledService.h"
#include "OnBoard.h"
#include "leds.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
// LED Service UUID: 
CONST uint8 LedServUUID[ATT_UUID_SIZE] = {
  BASE_UUID_128(LED_SERVICE_UUID)
};

// LED Data Characteristic UUID: 
CONST uint8 LedDataCharUUID[ATT_UUID_SIZE] = {
  BASE_UUID_128(LED_DATA_CHAR_UUID)
};

/*********************************************************************
 * EXTERNAL VARIABLES
 */

/*********************************************************************
 * EXTERNAL FUNCTIONS
 */

/*********************************************************************
 * LOCAL VARIABLES
 */

/*********************************************************************
 * Service Attributes - variables
 */

// Led Service attribute
static CONST gattAttrType_t LedService = { ATT_UUID_SIZE, LedServUUID };

// Led Data Characteristic
static uint8 LedDataCharProps = GATT_PROP_READ | GATT_PROP_WRITE | GATT_PROP_WRITE_NO_RSP;
static uint8 LedDataCharValue[LED_DATA_CHAR_LEN] = { 0, 0, 0, 0, 0, 0 };
static CONST uint8 LedDataCharUserDesc[] = "Led Data";


/*********************************************************************
 * Service Attributes - Table
 */

static gattAttribute_t LedServiceAttrTbl[] = 
{
  // Led Service
  { 
    { ATT_BT_UUID_SIZE, primaryServiceUUID }, /* type */
    GATT_PERMIT_READ,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&LedService              /* pValue */
  },

    // Characteristic 1 Declaration
    { 
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ, 
      0,
      &LedDataCharProps 
    },

      // Characteristic Value 1
      { 
        { ATT_UUID_SIZE, LedDataCharUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE, 
        0, 
        LedDataCharValue 
      },

      // Characteristic 1 User Description
      { 
        { ATT_BT_UUID_SIZE, charUserDescUUID },
        GATT_PERMIT_READ, 
        0, 
        (uint8 *)LedDataCharUserDesc 
      }

   
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 LedService_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t LedService_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset );

/*********************************************************************
 * PROFILE CALLBACKS
 */
// SB Config Profile Service Callbacks
CONST gattServiceCBs_t LedServiceCBs =
{
  LedService_ReadAttrCB,  // Read callback function pointer
  LedService_WriteAttrCB, // Write callback function pointer
  NULL                       // Authorization callback function pointer
};
/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      LedService_AddService
 *
 * @brief   Initializes the service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  Success or Failure
 */
bStatus_t LedService_AddService( void )
{
  uint8 status = SUCCESS;
  
  // Register GATT attribute list and CBs with GATT Server App
  status = GATTServApp_RegisterService( LedServiceAttrTbl, 
                                          GATT_NUM_ATTRS( LedServiceAttrTbl ),
                                          &LedServiceCBs );
  return ( status );
}

/*********************************************************************
 * @fn          LedService_ReadAttrCB
 *
 * @brief       Read an attribute.
 *
 * @param       connHandle - connection message was received on
 * @param       pAttr - pointer to attribute
 * @param       pValue - pointer to data to be read
 * @param       pLen - length of data to be read
 * @param       offset - offset of the first octet to be read
 * @param       maxLen - maximum length of data to be read
 *
 * @return      Success or Failure
 */
static uint8 LedService_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  bStatus_t status = SUCCESS;

  // If attribute permissions require authorization to read, return error
  if ( gattPermitAuthorRead( pAttr->permissions ) )
  {
    // Insufficient authorization
    return ( ATT_ERR_INSUFFICIENT_AUTHOR );
  }
  
  // Make sure it's not a blob operation (no attributes in the profile are long)
  if ( offset > 0 )
  {
    return ( ATT_ERR_ATTR_NOT_LONG );
  }
 
  if ( pAttr->type.len == ATT_UUID_SIZE )
  {
    // 128-bit UUID
    
    if (osal_memcmp(pAttr->type.uuid, LedDataCharUUID, ATT_UUID_SIZE)) {
      //Led Data UUID
             
      *pLen = LED_DATA_CHAR_LEN;    
      VOID osal_memcpy( pValue, pAttr->pValue, LED_DATA_CHAR_LEN );  
        
    } else {
      // Should never get here! 
      *pLen = 0;
      status = ATT_ERR_ATTR_NOT_FOUND;
    } 
               
  }
  else
  {
    // 16-bit UUID
    *pLen = 0;
    status = ATT_ERR_INVALID_HANDLE;
  }

  return ( status );
}

/*********************************************************************
 * @fn      LedService_WriteAttrCB
 *
 * @brief   Validate attribute data prior to a write operation
 *
 * @param   connHandle - connection message was received on
 * @param   pAttr - pointer to attribute
 * @param   pValue - pointer to data to be written
 * @param   len - length of data
 * @param   offset - offset of the first octet to be written
 * @param   complete - whether this is the last packet
 * @param   oper - whether to validate and/or write attribute value  
 *
 * @return  Success or Failure
 */
static bStatus_t LedService_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset )
{
  bStatus_t status = SUCCESS;
  
  // If attribute permissions require authorization to write, return error
  if ( gattPermitAuthorWrite( pAttr->permissions ) )
  {
    // Insufficient authorization
    return ( ATT_ERR_INSUFFICIENT_AUTHOR );
  }
  
  
  if ( pAttr->type.len == ATT_UUID_SIZE )
  {
    // 128-bit UUID
    
    if (osal_memcmp(pAttr->type.uuid, LedDataCharUUID, ATT_UUID_SIZE)) {
      //Led Data UUID
     
      //Write the value
      if ( len == LED_DATA_CHAR_LEN )
      {               
        osal_memcpy( pAttr->pValue, pValue, LED_DATA_CHAR_LEN );
                
        LedsSetTarget(LED_RED, pValue[0], pValue[1]);
        LedsSetTarget(LED_GREEN, pValue[2], pValue[3]);
        LedsSetTarget(LED_BLUE, pValue[4], pValue[5]);
        
      }
        
    }     
    
    else {
      // Should never get here!  
        status = ATT_ERR_ATTR_NOT_FOUND;
    } 
    
  }
  else
  {
    // 16-bit UUID
    status = ATT_ERR_INVALID_HANDLE;
  }

  return ( status );
}
    

/*********************************************************************
*********************************************************************/
