//
//  ElectricSpiral.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomObject.h"
@interface ElectricSpiral : NSObject {
    
    RoomObject *spiralObj;
    RoomObject *panelObj;
    NSDictionary *propertyMap;
     
}

@property (nonatomic, retain) RoomObject *spiralObj;
@property (nonatomic, retain) RoomObject *panelObj;
@property (nonatomic, retain) NSDictionary *propertyMap;



@end
