/******************************************************************************
    Copyright (C) Studio Sophisti 2013
    Author: Tijn Kooijmans, tijn@studiosophisti.nl
******************************************************************************/

#include "leds.h"

#include "OnBoard.h"
#include <math.h>

int red_target = 0x00;
int red_current = 0x00;
int red_speed = 0x01;

int green_target = 0x00;
int green_current = 0x00;
int green_speed = 0x01;

int blue_target = 0x00;
int blue_current = 0x00;
int blue_speed = 0x01;

void LedSetRed(unsigned char duty_cycle);
void LedSetGreen(unsigned char duty_cycle);
void LedSetBlue(unsigned char duty_cycle);

void LedsInit() {       
  LedSetRed(red_current);
  LedSetGreen(green_current);
  LedSetBlue(blue_current);
}

void LedsSetTarget(LED_Id led, unsigned char target, unsigned char speed) {
  if (speed == 0) speed = 1;
  
  if (led == LED_RED) {
    red_target = target;
    red_speed = speed;
    
  } else if (led == LED_GREEN) {
    green_target = target;
    green_speed = speed;   
    
  } else if (led == LED_BLUE) {
    blue_target = target;
    blue_speed = speed;    
    
  }  
  LedsUpdate();
}

void LedsUpdate() {      
    
  if (red_target > red_current)  {
    red_current += red_speed;
    red_current = MIN(red_target, red_current);
  } else if (red_target < red_current) {
    red_current -= red_speed;
    red_current = MAX(red_target, red_current);
  }
  
  if (green_target > green_current) {
    green_current += green_speed;
    green_current = MIN(green_target, green_current);
  } else if (green_target < green_current) {
    green_current -= green_speed;
    green_current = MAX(green_target, green_current);
  }
  
  if (blue_target > blue_current) {
    blue_current += blue_speed;
    blue_current = MIN(blue_target, blue_current);
  } else if (blue_target < blue_current) {
    blue_current -= blue_speed;
    blue_current = MAX(blue_target, blue_current);
  }
  
  // update pwm duty cycles
  LedSetRed((unsigned char)red_current);
  LedSetGreen((unsigned char)green_current);
  LedSetBlue((unsigned char)blue_current);
}

void LedSetRed(unsigned char duty_cycle) {
    
  duty_cycle = 0xFF - duty_cycle;
  if (duty_cycle == 0x00) duty_cycle = 0xFF;
  else if (duty_cycle == 0xFF) duty_cycle = 0x00;
  
  PERCFG &= ~0x10; // Select Timer 4 Alternative 1 location 1
  P2SEL |= 0x10; // Give priority to Timer 4
  P1SEL |= 0x02; // Set P1.1 to peripheral
  
  T4CC0 = 0xFF;   // PWM signal period    
  T4CC1 = duty_cycle;
  
  T4CCTL1 = 0x1C;
  
  T4CTL = 0xF3;   // start   
    
}

void LedSetGreen(unsigned char duty_cycle) {
    
  duty_cycle = 0xFF - duty_cycle;
  if (duty_cycle == 0x00) duty_cycle = 0xFF;
  else if (duty_cycle == 0xFF) duty_cycle = 0x00;
  
  PERCFG &= ~0x20; // Select Timer 3 Alternative 1 location 1
  P2SEL |= 0x20; // Give priority to Timer 3
  P1SEL |= 0x10; // Set P1.4 to peripheral
  
  T3CC0 = 0xFF;   // PWM signal period    
  T3CC1 = duty_cycle;
  
  T3CCTL1 = 0x1C;
  
  T3CTL = 0xF3;   // start   
  
}

void LedSetBlue(unsigned char duty_cycle) {
    
  duty_cycle = 0xFF - duty_cycle;
  if (duty_cycle == 0x00) duty_cycle = 0xFF;
  else if (duty_cycle == 0xFF) duty_cycle = 0x00;
  
  PERCFG &= ~0x40; // Select Timer 1 Alternative 1 location 1
  P2DIR = (P2DIR & ~0xC0) | 0x80; // 1st priority: Timer 1 channels 0–1
  P0SEL |= 0x08;  // Set P0.3 to peripheral
  
  T1CC0L = 0xFF;   // PWM signal period
  T1CC0H = 0x00;
  
  T1CC1L = duty_cycle;
  T1CC1H = 0x00;
  
  T1CCTL1 = 0x1C;
  
  T1CTL |= 0x0F;   // start   
    
}