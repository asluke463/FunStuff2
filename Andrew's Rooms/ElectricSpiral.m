//
//  ElectricSpiral.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ElectricSpiral.h"
#import "RoomLayer.h"
#import "RoomObject.h"
#import "Tags.h"
@implementation ElectricSpiral
@synthesize spiralObj, panelObj, propertyMap;


- (id)initWithRoomLayer:(RoomLayer *)layer  {
    
    if (self = [super init]) {

        self.spiralObj = [RoomObject roomObjectWithRoomLayer:layer objectTag:spiral];
        
        self.panelObj = [RoomObject roomObjectWithRoomLayer:layer objectTag:panel];
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}

+ (id)electricSpiralForRoomLayer:(RoomLayer *)layer {
    return [[[self alloc] initWithRoomLayer:layer] autorelease];
}

@end
