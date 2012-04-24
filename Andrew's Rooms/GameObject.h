//
//  GameObject.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tags.h"

// GameObjects can be in different states based on user interaction
// Objects of this class are expected to be Interactive (otherwise they're just pictures/spriteFrames)

// TODO: I CAN MOVE THE WIRES WHEN PANEL IS STILL CLOSED. HAVE TO NOT BE ABLE TO SET STATE OF PLUGS UNTIL AFTER I CLICK ON PANEL. HAVE TO INHERIT FROM GAMEOBJCT AND PUT COMPONENTS 
@class RoomLayer;
@class InfoButton;
@interface GameObject : CCNode <CCTargetedTouchDelegate> {
        
    // loads all sprites with predetermined properties from plist
    NSDictionary *baseObjectMap;
    InteractionState interactionState;    
    CGRect touchDetectionRect;
    
    InfoButton *infoBubble;
    
    ObjectTags objectTag;
    
    BOOL oneSpriteTouched;
}

@property (nonatomic, retain) NSDictionary *baseObjectMap;
@property (nonatomic, assign) InteractionState interactionState;
@property (nonatomic, assign) CGRect touchDetectionRect;
@property (nonatomic, retain) InfoButton *infoBubble;
@property (nonatomic, assign) ObjectTags objectTag;
@property (nonatomic, assign) BOOL oneSpriteTouched;

+ (id)objectWithBaseName:(NSString *)baseName roomLayer:(RoomLayer *)layer;
- (id)initWithBaseName:(NSString *)baseName roomLayer:(RoomLayer *)layer;
- (void)addSpriteToGameObject:(NSString *)baseName objectName:(NSString *)objectName;
- (void)updateDetectionRect:(CGRect)rect;
- (void)transitionGameObjectToState:(InteractionState)newState;
@end
