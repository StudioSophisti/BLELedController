/******************************************************************************
    Copyright (C) Studio Sophisti 2013
    Author: Tijn Kooijmans, tijn@studiosophisti.nl
******************************************************************************/

#ifndef LEDS_H
#define LEDS_H

#include "hal_types.h"

/*===========================================================================
 * TYPES
 *=========================================================================*/

typedef enum
{
    LED_RED = 0,
    LED_GREEN,
    LED_BLUE

} LED_Id;

void LedsInit();
void LedsSetTarget(LED_Id led, unsigned char target, unsigned char speed);
void LedsUpdate();

#endif

