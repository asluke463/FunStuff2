//
//  InfoBubbleComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoBubbleComponent.h"
#import "InfoBubbleGraphicsComponent.h"
#import "InputComponent.h"
#import "RoomObject.h"

@implementation InfoBubbleComponent
@synthesize roomObject;


- (void)Receive:(SignalID)signal {

    switch (signal) {
        case RoomObjectWasTouched:
            [self Send:RoomObjectWasTouched];
            break;

        case OtherInfoBubbleWasDisplayed:
            [self Send:OtherInfoBubbleWasDisplayed];
            break;
        
        case InfoBubbleWasTouched: 
            [self Send:InfoBubbleWasTouched];
            break;
            
        default:
            break;
    }    
}

- (CGRect)getTrueRectForRoomObject {
    
    return [self.roomObject getTrueRectForCurrentState];
}

- (id)initForRoomObject:(RoomObject *)roomObj {
    
    if (self = [super init]) {
        self.roomObject = roomObj;
        self.components = [[NSMutableArray alloc] init];
        
        [self.components addObject:[InfoBubbleGraphicsComponent infoBubbleGraphicsComponentForInfoBubbleComponent:self]];
        
        [self.components addObject:[InputComponent inputComponentWithParent:self]];
        
        [self allComponentsAreValid:self.components];

        if ([self allComponentsAreValid:self.components])
            [self Send:AllComponentsInitialized];
    }
    return self;
}

+ (id)infoBubbleComponentForRoomObject:(RoomObject *)roomObject {
    
    return [[[self alloc] initForRoomObject:roomObject] autorelease];
}


- (void)dealloc
{
    [roomObject release];
    [super dealloc];
}
@end
