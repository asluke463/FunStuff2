//
//  InventoryObject.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"
@class InventoryBar;
@interface InventoryObject : GameObject {

    InventoryBar *invenBar; 
}

@property (nonatomic, retain) InventoryBar *invenBar;

+ (id)inventoryBarObjectWithSprite:(CCSprite *)sprite tag:(ObjectTags)tag inventoryBar:(InventoryBar *)bar;
@end
