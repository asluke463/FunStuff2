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
    
    RoomLayer *roomLayer;
    
    // A map of object properties (like position and size) loaded from a the object plist of the corresponding room
    NSDictionary *basePropertyMap;
    
    int roomNumber;
}
@property (nonatomic, retain) RoomLayer *roomLayer;
@property (nonatomic, retain) NSDictionary *basePropertyMap;
@property (nonatomic, assign) int roomNumber;
//+ (void)loadRoomAssets:(int)roomNum;

//- (id)initRoomLoaderWithRoomNumber:(int)roomNum;
- (void)loadAssetsForRoom:(int)roomNum roomLayer:(RoomLayer *)layer;

// For unit testing
- (void)setupTaggedRoomObjectPropertyArrayFromMap:(NSDictionary *)map;
-(NSDictionary *)readInPlistForRoom:(NSNumber *)roomNum;
//- (id)initRoomLoaderWithFirstRoomAssets;

@end
