//
//  RoomLoader.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RoomLayer;
@interface RoomLoader : NSObject {
    
    NSDictionary *objectPropertyListForCurrentRoom;
}

@property (nonatomic, retain) NSDictionary *objectPropertyListForCurrentRoom;
//+ (void)loadRoomAssets:(int)roomNum;

//- (id)initRoomLoaderWithRoomNumber:(int)roomNum;
- (void)loadAssetsForRoom:(int)roomNum roomLayer:(RoomLayer *)layer;
//- (id)initRoomLoaderWithFirstRoomAssets;

@end
