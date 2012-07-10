//
//  TestGameObject.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomObject.h"
#import "RoomSubObject.h"
#import "InputComponent.h"
#import "RoomObjectGraphicsComponent.h"
#import "InfoBubbleComponent.h"
#import "Tags.h"
#import "RoomLayer.h"
#import "RoomLoader.h"

@implementation RoomObject
@synthesize roomLayer, roomObjectPropertyMap, delegate;

- (CCArray *)subObjects {
    CCArray *subObjs = [CCArray arrayWithArray:[self children]];
    NSMutableArray *temps = [NSMutableArray array];
    CCNode *node;
    CCARRAY_FOREACH(subObjs, node) {
        if ([node isKindOfClass:[RoomSubObject class]]) {
            [temps addObject:(RoomSubObject *)node];
        }
    }
    
    return [CCArray arrayWithNSArray:temps];
}
- (void)addLockToAllSubObjects {
    
    CCArray *subObjects = self.subObjects;
    CCNode *node;
    CCARRAY_FOREACH(subObjects, node) {

        NSAssert([node isKindOfClass:[RoomSubObject class]], @"RoomObject had a non-Subject child!");
        RoomSubObject *subObject = (RoomSubObject *)node;
        if (![subObject hasLockComponent] && !subObject.isActivator)
            [subObject addLockComponent];
    }
}

- (void)unlockAllSubObjects {
    
    CCArray *subObjects = self.subObjects;
    CCNode *node;
    CCARRAY_FOREACH(subObjects, node) {
        
        RoomSubObject *subObject = (RoomSubObject *)node;
        if ([subObject hasLockComponent] && !subObject.isActivator)
            [subObject Send:IWasUnlocked];
    }


}

- (void)toggleInteractable {
    
    for (id comp in self.components) {
        if ([comp isKindOfClass:[InputComponent class]]) {
            InputComponent *input = (InputComponent*)comp;
            if (input.on)
                input.on = NO;
            else {
                input.on = YES;
            }
        }
    }
}



- (void)addSubObjectToRoomObject:(ObjectTags)subObjectTag {
    
    [RoomSubObject subObjectWithRoomObject:self subObjectTag:subObjectTag];
}

- (void)addSubObjects {
    self.roomObjectPropertyMap = [[NSDictionary alloc] initWithDictionary:[self.roomLayer.roomObjectProperties objectForKey:[NSNumber numberWithInt:self.tag]]]; 
    
    NSArray *objectNameKeys = [[NSArray alloc] initWithArray:[roomObjectPropertyMap allKeys]];
    
    // Add All SubRoomObjects
    for (NSNumber *subObjectTag in objectNameKeys) {
        [self addSubObjectToRoomObject:[subObjectTag intValue]];
    }
    
    [objectNameKeys release];

}

// if objects have greater than one frame from plist, it implies that they're interactive
- (id)initWithRoomLayer:(RoomLayer *)layer objectTag:(ObjectTags)objTag {
        
    if ((self = [super init])) {
        self.roomLayer = layer;
        self.tag = objTag;
        self.interactionState = RegularState;
        if (objTag == background) {
            self.interactionState = NonInteractiveState;
        } 
       
        // Add the approriate components
        self.components = [[NSMutableArray alloc] init];
        [self.components addObject:[RoomObjectGraphicsComponent roomObjectGraphicsComponentWithRoomObject:self]];
        
        // SET THE DETECTION RECT AND STUFF LATER! JUST ADD ALL COMPONENTS :)
        
        if (self.interactionState == RegularState) {
            // Add InputComponent
            [self.components addObject:[InputComponent inputComponentWithParent:self]];
        }
        
       // Adds sub objects to the object (like colored plugs)
        [self addSubObjects];
               

        if (self.interactionState == RegularState) {
            // Add InfoBubble If needed
            [self.components addObject:[InfoBubbleComponent infoBubbleComponentForRoomObject:self]];
        }
        
        if ([self allComponentsAreValid:self.components])
            [self Send:AllComponentsInitialized];

    }
    return self;
}

+ (id)roomObjectWithRoomLayer:(RoomLayer *)layer objectTag:(ObjectTags)objTag {
    
    return [[[self alloc] initWithRoomLayer:layer objectTag:objTag] autorelease];
    
}

- (void)dealloc
{
    [roomObjectPropertyMap release];
    [roomLayer release];
    [super dealloc];
}


@end
