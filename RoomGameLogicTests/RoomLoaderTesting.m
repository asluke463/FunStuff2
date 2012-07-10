//
//  RoomLoader.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomLoaderTesting.h"
#import "Tags.h"


@implementation RoomLoaderTesting
@synthesize basePropertyMap;

// this map is just the Root dictionary
- (void)setupTaggedRoomObjectPropertyArrayFromMap:(NSDictionary *)map {
    
    NSArray *allBaseObjectKeys = [map allKeys]; // background, panel, spiral...
    NSMutableDictionary *propertyDict = [[NSMutableDictionary alloc] init];
    
    for (NSString *objectBaseName in allBaseObjectKeys) {
        NSDictionary *baseObjectMap = [map objectForKey:objectBaseName];        
        NSArray *allSubObjectKeys = [baseObjectMap allKeys]; // blankSurge, shut, R_plug, etc...
        
        ObjectTags baseObjectTag = [Tags convertToObjectTagFromString:objectBaseName];
        
        [propertyDict setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:baseObjectTag]];
//        [propertyDict insertObject:[NSMutableArray array] atIndex:baseObjectTag];
        
        for (NSString *subObjectName in allSubObjectKeys) {
            NSString *fullName = [[NSString alloc] initWithFormat:@"%@_%@", objectBaseName, subObjectName];
            NSDictionary *subObjectMap = [baseObjectMap objectForKey:subObjectName];        
            
            ObjectTags subObjectTag = [Tags convertToObjectTagFromString:fullName];
            
//            [[propertyDict objectForKey:baseObjectTag] setObj:subObjectArray atIndex:subObjectTag];
            [[propertyDict objectForKey:[NSNumber numberWithInt:baseObjectTag]] setObject:subObjectMap forKey:[NSNumber numberWithInt:subObjectTag]];
        }
    }
    self.basePropertyMap = [NSDictionary dictionaryWithDictionary:propertyDict];
}

//- (void)load
-(NSDictionary *)readInPlistForRoom:(NSNumber *)roomNum {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *basePath = [NSString stringWithFormat:@"room%d-objects", [roomNum intValue]];
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    //    plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", basePath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:basePath ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];

    NSDictionary *temp2 = [[NSDictionary alloc] initWithDictionary:[temp objectForKey:@"Root"]];
    if (!temp2) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    return temp2;
}



- (void)dealloc
{
    //    [objectPropertyListForCurrentRoom release];
    [super dealloc];
}

@end
