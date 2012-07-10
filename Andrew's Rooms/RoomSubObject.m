//
//  RoomSubObject.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomSubObject.h"
#import "RoomSubObjectGraphicsComponent.h"
#import "RoomObject.h"
#import "RoomLayer.h"
#import "States.h"
#import "InputComponent.h"
#import "Debug.h"
#import "PropertyMapChecker.h"
#import "Tags.h"
#import "LockComponent.h"
#import "ActivationComponent.h"
#import "CollectabilityComponent.h"


@implementation RoomSubObject
@synthesize subObjectState, objectPropertiesMap, isParentTouchDetector;
@synthesize isInteractable, roomObject, isActivator, delegate, linkedObjectTag, hasLinkedObject;
@synthesize collectable;

- (BOOL)findLinkedObject {
    if (self.objectPropertiesMap) {
        NSString *linkedObjectSubName = [self.objectPropertiesMap objectForKey:@"linkedObject"];
        if (!linkedObjectSubName) return NO;
        self.linkedObjectTag = [Tags convertToObjectTagFromString:linkedObjectSubName];
        ObjectTags baseTag = [Tags convertToObjectTagFromString:[linkedObjectSubName substringToIndex:[linkedObjectSubName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"_"]].location]];
        CCArray *roomObjects = [self.roomObject.roomLayer roomObjects];
        RoomObject *roomObj;
        CCARRAY_FOREACH(roomObjects, roomObj) {
            if (roomObj.tag == baseTag) {
                CCArray *subObjects = roomObj.subObjects;
                RoomSubObject *roomSubObj;
                CCARRAY_FOREACH(subObjects, roomSubObj) {
                    if (roomSubObj.tag == self.linkedObjectTag) {
                        self.delegate = roomSubObj;
                        return YES;
                    }
                }
            }
        }
//        self.delegate = 
    } else {
        [NSException raise:NSInternalInconsistencyException 
                    format:@"must initialize subObjectPropertiesMap before you can call this method %@", NSStringFromSelector(_cmd)];
    }
    
    return NO;
}


- (BOOL)hasActivationObject {
    
    NSArray *allKeys = [self.objectPropertiesMap allKeys];
    for (NSNumber *key in allKeys) {
        
        if ([[self.objectPropertiesMap objectForKey:key] isKindOfClass:[NSString class]]) continue;
        if ([[self.objectPropertiesMap objectForKey:key] objectForKey:@"activator"])
            return YES;
    }
    return NO;
}

- (BOOL)hasActivationComponent {

    BOOL has = NO;
    for (id comp in self.components) {
        if ([comp isKindOfClass:[ActivationComponent class]]) has = YES;
    }
    
    return has;
}
- (BOOL)hasLockComponent {
    BOOL has = NO;
    for (id comp in self.components) {
        if ([comp isKindOfClass:[LockComponent class]]) has = YES;
    }
    
    return has;
}

- (void)addActivationComponent {
    
    for (id comp in self.components) {
        NSAssert(![comp isKindOfClass:[ActivationComponent class]],@"Trying to add activation component when class already has one!");
    }
    
[self.components addObject:[ActivationComponent activationComponentWithSubObject:self]];
}

- (void)addLockComponent {
    
    for (id comp in self.components) {
        NSAssert(![comp isKindOfClass:[LockComponent class]],@"Trying to add lock component when class already has one!");
    }
    
    [self.components addObject:[LockComponent lockComponentWithGameObject:self] ];
}
- (void)toggleInteractable {
    
    if (self.isInteractable) {
        self.isInteractable = NO;
        for (id comp in self.components) {
            if ([comp isKindOfClass:[InputComponent class]]) {
                InputComponent *input = (InputComponent*)comp;
                input.on = NO;
            }
        }
    } else {
        self.isInteractable = YES;
        for (id comp in self.components) {
            if ([comp isKindOfClass:[InputComponent class]]) {
                InputComponent *input = (InputComponent*)comp;
                input.on = YES;
                return;
            }
        }
        
        // Add necessary components, etc
        if ([self allComponentsAreValid:self.components])
            [self Send:NeedToSetDetectionRect];
    }
}

- (void)toggleCollectable {
    
    if (self.collectable) {
        self.collectable = NO;
        for (id comp in self.components) {
            if ([comp isKindOfClass:[CollectabilityComponent class]]) {
                CollectabilityComponent *collect = (CollectabilityComponent*)comp;
                collect.canCollectNow = NO;
            }
        }
    } else {
        self.collectable = YES;
        for (id comp in self.components) {
            if ([comp isKindOfClass:[CollectabilityComponent class]]) {
                CollectabilityComponent *collect = (CollectabilityComponent*)comp;
                collect.canCollectNow = YES;
                return;
            }
        }
        
        //
//        [self allComponentsAreValid:self.components];

    }
}
- (CGRect)getBoundingBoxForCurrentState {
    
    for (id comp in self.components) {
        if ([comp isKindOfClass:[RoomSubObjectGraphicsComponent class]]) {
            RoomSubObjectGraphicsComponent *gc = (RoomSubObjectGraphicsComponent *)comp;
            return [gc.currentSprite boundingBox];
        }
    }
    
//    [NSException raise:NSInternalInconsistencyException 
//                format:@"there's no RoomSubObjectGraphicsComponent in this subObject! method:%@", NSStringFromSelector(_cmd)];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"there's no RoomSubObjectGraphicsComponent in this subObject! method:%@", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}


- (NSDictionary *)getPropertyMapForState:(SubObjectState)state {
    
    if (self.objectPropertiesMap) {
        
        id dict = [self.objectPropertiesMap objectForKey:[NSString stringWithFormat:@"State_%d", state]];
        if ([dict isKindOfClass:[NSDictionary class]]) 
            return [NSDictionary dictionaryWithDictionary:((NSDictionary *)dict)];
        return nil;
    } else {
        [NSException raise:NSInternalInconsistencyException 
                     format:@"must initialize subObjectPropertiesMap before you can call this method %@", NSStringFromSelector(_cmd)];
        return nil;

    }
}

- (id)initWithRoomObject:(RoomObject *)roomObj subObjectTag:(ObjectTags)subTag {
    
    if (self = [super init]) {
        self.roomObject = roomObj;
        self.subObjectState = State0;
        self.interactionState = RegularState;
        self.tag = subTag;
        if (subTag == background_background) {
            self.interactionState = NonInteractiveState;   
        }

        self.objectPropertiesMap = [roomObject.roomObjectPropertyMap objectForKey:[NSNumber numberWithInt:subTag]];
        if (DEBUG_STATUS == 1) {
            [PropertyMapChecker assertMapHasAllRequiredObjectProperties:self.objectPropertiesMap subName:[Tags convertToStringFromObjectTag:subTag]];
        }
        
        NSDictionary *currentStatePropertyMap = [self getPropertyMapForState:State0];
        
        if ([currentStatePropertyMap objectForKey:@"parentsTouchDetector"]) {
            self.isParentTouchDetector = YES;
        } else {
            self.isParentTouchDetector = NO;
        }
        // TODO debug spiral pickup
        if (self.tag == spiral_P) 
            CCLOG(@"Debug");
        
        if ([currentStatePropertyMap objectForKey:@"interaction"]) {
            self.isInteractable = YES;
        } else {
            self.isInteractable = NO;
        }
        
        // TODO testing
        if ([currentStatePropertyMap objectForKey:@"collectable"] || self.tag == spiral_P) {
            self.collectable = YES;
        } else {
            self.collectable = NO;
        }
        
        
        

        
    
        
        self.components = [[NSMutableArray alloc] init];
        [self.components addObject:[RoomSubObjectGraphicsComponent roomSubObjectGraphicsComponentWithRoomObject:self]];
        
        // add Collectability component
        if (self.collectable) {
            [self.components addObject:[CollectabilityComponent collectabilityComponentWithObject:self]];
        }        

        // TODO THIS WILL NEVER GET ADDED FIX THIS
        if ([self hasActivationObject]) {
            self.isActivator = YES;
            [self addActivationComponent];
        } else {
//            CCLOG(@"Activator set to NO for %@", [Tags convertToStringFromObjectTag:self.tag]);
            self.isActivator = NO;
        }

        // this is why all object scan for input1
//        if (self.isInteractable) {
            [self.components addObject:[InputComponent inputComponentWithParent:self]];
//        }        
        

        self.tag = subTag;
        
        // Add necessary components, etc
        if ([self allComponentsAreValid:self.components])
            [self Send:AllComponentsInitialized];
        
        [roomObject addChild:self z:0 tag:subTag];
        
    }
    
    return self;
}

+ (id)subObjectWithRoomObject:(RoomObject *)roomObject subObjectTag:(ObjectTags)subTag {
    
    return [[[self alloc] initWithRoomObject:roomObject subObjectTag:subTag] autorelease];
}

- (void)dealloc
{
    [objectPropertiesMap release];
    [roomObject release];
    [super dealloc];
}

@end
