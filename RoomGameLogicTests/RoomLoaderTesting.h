//
//  RoomLoader.h
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface RoomLoaderTesting : NSObject {
    

    NSDictionary *basePropertyMap;
}

@property (nonatomic, retain) NSDictionary *basePropertyMap;
//+ (void)loadRoomAssets:(int)roomNum;

//- (id)initRoomLoaderWithRoomNumber:(int)roomNum;


// For unit testing
- (void)setupTaggedRoomObjectPropertyArrayFromMap:(NSDictionary *)map;
-(NSDictionary *)readInPlistForRoom:(NSNumber *)roomNum;
//- (id)initRoomLoaderWithFirstRoomAssets;

@end
