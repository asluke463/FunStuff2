//
//  CloseUpLayer.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// All sprites of layer go in here

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RoomObject;
@class BackButton;
@interface CloseUpLayer : CCLayer {
        
    BackButton *backButton;
}

@property (nonatomic, retain) BackButton *backButton;

- (void)addBackButton;
- (void)loadRoomObject:(RoomObject *)roomObject;
@end
