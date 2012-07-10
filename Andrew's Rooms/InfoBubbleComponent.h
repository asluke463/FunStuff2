//
//  InfoBubbleComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "Component.h"

@class RoomObject;
@interface InfoBubbleComponent : GameObject <Component> {
    
//    InfoBubbleGraphicsComponent *graphics;
//    InputComponent *input;
    RoomObject *roomObject;
}

//@property (nonatomic, retain) InfoBubbleGraphicsComponent *graphics;
//@property (nonatomic, retain) InputComponent *input;
@property (nonatomic, assign) RoomObject *roomObject;

- (CGRect)getTrueRectForRoomObject;
+ (id)infoBubbleComponentForRoomObject:(RoomObject *)roomObj;

@end
