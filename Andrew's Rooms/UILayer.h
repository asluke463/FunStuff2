//
//  UILayer.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


typedef enum {
    UILayerTagFrameSprite,
} UILayerTags;

@class InventoryBar;
@interface UILayer : CCLayer {
    
    InventoryBar *inventoryBar;
}

@property (nonatomic, retain) InventoryBar *inventoryBar;
- (BOOL)isTouchForMe:(CGPoint)touchLocation;

@end
