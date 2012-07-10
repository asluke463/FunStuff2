//
//  CollectabilityComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

// Makes an object collectable 

@class GameObject;
@class UILayer;
@interface CollectabilityComponent : NSObject <Component> {
    
    BOOL canCollectNow; // if certain conditions are met, the object is not collectable
    GameObject *gameObj;
//    UILayer *uiLayer;
}

@property (nonatomic, assign) BOOL canCollectNow;
@property (nonatomic, assign) GameObject *gameObj;
//@property (nonatomic, assign) UILayer *uiLayer;

+ (id)collectabilityComponentWithObject:(GameObject *)object;

- (void)moveObjectToInventory;


@end
