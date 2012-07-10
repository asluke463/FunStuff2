//
//  Component.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentSignalsIDs.h"

@protocol Component <NSObject>

// Receives a message sent by another object and performs a domain-specific action
- (void)Receive:(SignalID)signal; 
@end
