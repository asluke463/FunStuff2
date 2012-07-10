//
//  InventoryObjectGraphicsComponent.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class InventoryObject;
@interface InventoryObjectGraphicsComponent : CCNode {
 
    CCSprite *sprite;
    InventoryObject *inventoryObject;
    BOOL isSelected;
}

@property (nonatomic, assign) BOOL isSelected;
@property(nonatomic, retain) CCSprite *sprite;
@property(nonatomic, retain) InventoryObject *inventoryObject;

+ (id)inventoryGraphicsComponentWithSprite:(CCSprite *)sprit inventoryObject:(InventoryObject *)object;

@end
