//
//  RoomLoader.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomLoader.h"
#import "GameObject.h"
#import "RoomScene.h"


@implementation RoomLoader

@synthesize objectPropertyListForCurrentRoom;
//- (id)initRoomLoaderWithRoomNumber:(int)roomNum {
//    
//    if ((self = [super init])) {
//        
//        switch (roomNum) {
//            case <#constant#>:
//                <#statements#>
//                break;
//                
//            default:
//                break;
//        }
//        
//    }
//    return self;
//}
-(void)readInPlistForRoom:(NSNumber *)roomNum {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *basePath = [NSString stringWithFormat:@"room%d-objects", [roomNum intValue]];
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    //    plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", basePath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:basePath ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    
    self.objectPropertyListForCurrentRoom = [[NSDictionary alloc] initWithDictionary:[temp objectForKey:@"Root"]];
    if (!self.objectPropertyListForCurrentRoom) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
}
//- (id)initRoomLoaderWithFirstRoomAssets {
//    
//    if ((self = [super init])) {
//        
//        [self readInPlistForRoom:[NSNumber numberWithInt:1]];
//    }
//    
//    return self;
//}

//+ (void)loadRoomAssets:(int)roomNum {
//
//    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//    
//    switch (roomNum) {
//        case 1:
//            [frameCache addSpriteFramesWithFile:@"room1-art.plist"];
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)addGameObjectsForRoomNumber:(int)roomNum roomLayer:(RoomLayer *)layer {
    
    [self readInPlistForRoom:[NSNumber numberWithInt:roomNum]];
    
    NSArray *allKeys = [self.objectPropertyListForCurrentRoom allKeys];
    
    for (NSString *objectBaseName in allKeys) {
        [GameObject objectWithBaseName:objectBaseName roomLayer:layer];
    }
    
}
- (void)loadAssetsForRoom:(int)roomNum roomLayer:(RoomLayer *)layer {
    
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"room%d-art.plist", roomNum]];
    [self addGameObjectsForRoomNumber:roomNum roomLayer:layer];

}



- (void)dealloc
{
    [objectPropertyListForCurrentRoom release];
    [super dealloc];
}

@end
