//
//  RoomLoader.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomLoader.h"
#import "RoomLayer.h"
#import "RoomObject.h"
#import "RoomScene.h"
#import "Tags.h"
#import "ObjectMediator.h"

@implementation RoomLoader
@synthesize roomLayer, basePropertyMap, roomNumber;

/*
 ============
 setupTaggedRoomObjectPropertyArrayFromMap
 
 Sets up the basePropertyMap for this room so that everything can be referenced by Tag. This map contains all the data about room object art -their position, width, zOrder, etc.
 ============
 */
- (void)setupTaggedRoomObjectPropertyArrayFromMap:(NSDictionary *)map {
    
    NSArray *allBaseObjectKeys = [[NSArray alloc] initWithArray:[map allKeys]]; // background, panel, spiral...
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    
    for (NSString *objectBaseName in allBaseObjectKeys) {
        NSDictionary *baseObjectMap = [[NSDictionary alloc] initWithDictionary:[map objectForKey:objectBaseName]];
        NSAssert([baseObjectMap isKindOfClass:[NSDictionary class]], @"baseObjectMap is not a map type class!, double check that plist for room number: %d", self.roomNumber);
        NSArray *allSubObjectKeys = [[NSArray alloc] initWithArray:[baseObjectMap allKeys]]; // blankSurge, shut, R_plug, etc...
        
        ObjectTags baseObjectTag = [Tags convertToObjectTagFromString:objectBaseName];
        
        [propertyDict setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:baseObjectTag]];
        
        for (NSString *subObjectName in allSubObjectKeys) {
            NSString *fullName = [[NSString alloc] initWithFormat:@"%@_%@", objectBaseName, subObjectName];
            ObjectTags subObjectTag = [Tags convertToObjectTagFromString:fullName];
            [fullName release];
            NSDictionary *subObjectMap = [[NSDictionary alloc] initWithDictionary:[baseObjectMap objectForKey:subObjectName]];        
            
            [[propertyDict objectForKey:[NSNumber numberWithInt:baseObjectTag]] setObject:subObjectMap forKey:[NSNumber numberWithInt:subObjectTag]];
            [subObjectMap release];
        }
        [baseObjectMap release];
        [allSubObjectKeys release];
    }
    
    [allBaseObjectKeys release];
    self.basePropertyMap = [[NSDictionary alloc] initWithDictionary:propertyDict];
}

/*
 ============
 readInPlistForRoom
 
 reads in room art plist file, which must be of form room%d-objects, where %d is an integer and be located in Resources folder
 ============
 */
-(NSDictionary *)readInPlistForRoom:(NSNumber *)roomNum {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *basePath = [NSString stringWithFormat:@"room%d-objects", [roomNum intValue]];
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
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
    
    NSDictionary *temp2 = [NSDictionary dictionaryWithDictionary:[temp objectForKey:@"Root"]];
//    NSDictionary *temp2 = [[NSDictionary alloc] initWithDictionary:[temp objectForKey:@"Root"]];
    if (!temp2) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    return temp2;
}


- (void)addRoomObjectsForRoomNumber:(int)roomNum roomLayer:(RoomLayer *)layer {
    
    NSArray *allKeys = [self.basePropertyMap allKeys];
    for (NSNumber *objectNum in allKeys) {
        [RoomObject roomObjectWithRoomLayer:layer objectTag:[objectNum intValue]];
    }
    
}
- (void)loadAssetsForRoom:(int)roomNum roomLayer:(RoomLayer *)layer {
    
    self.roomNumber = roomNum;
    
    self.roomLayer = layer;
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    [frameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"room%d-art.plist", roomNum]];
    
    [self setupTaggedRoomObjectPropertyArrayFromMap:[self readInPlistForRoom:[NSNumber numberWithInt:roomNum]]];
    self.roomLayer.roomObjectProperties = [NSDictionary dictionaryWithDictionary:self.basePropertyMap];
    [self addRoomObjectsForRoomNumber:roomNum roomLayer:layer];
    
    if (roomNum == 1)
        [self.roomLayer addObjectMediator:[ObjectMediator objectMediatorWithActive:(GameObject*)[self.roomLayer getChildByTag:panel] passive:(GameObject*)[self.roomLayer getChildByTag:spiral]]];


}



- (void)dealloc
{
    [self.basePropertyMap release];
    [super dealloc];
}

@end
