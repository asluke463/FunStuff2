////
////  CloseUpLayer_One.m
////  Andrew's_Rooms
////
////  Created by Andrew Luke on 4/20/12.
////  Copyright 2012 __MyCompanyName__. All rights reserved.
////
//
//#import "CloseUpLayer_One.h"
//#import "RoomScene.h"
//
//
//@implementation CloseUpLayer_One
//
//- (id)init {
//    
//    if ((self = [super init])) {
//            
//    }
//    return self;
//}
//
//- (void)loadSpiral {
//
//    NSDictionary *closeUpMap = [NSDictionary dictionaryWithDictionary:[[RoomScene sharedRoomScene].objectPropertyListForCurrentRoom objectForKey:@"closeUpLayerObject"]];
//    
//    CloseUpObject *spiral = [CloseUpObject spiral_objectFromDictionary:closeUpMap];
//    
//    [self addChild:spiral z:0 tag:SpiralPaintingTag];
//}
//
//- (void)loadCloseUpObject:(NSString *)baseName; {
//        
//    NSDictionary *masterMap = [NSDictionary dictionaryWithDictionary:[[RoomScene sharedRoomScene].objectPropertyListForCurrentRoom objectForKey:baseName]];
//    
//    NSDictionary *closeUpMap = [NSDictionary dictionaryWithDictionary:[masterMap objectForKey:@"closeUpLayerObject"]];
//    
//
//    
//    CloseUpObject *spiral = [CloseUpObject spiral_objectFromDictionary:closeUpMap];
//    
//    [self addChild:spiral z:0 tag:SpiralPaintingTag];
//    
//    
//}
//
//- (void)dealloc
//{
//    [super dealloc];
//}
//
//@end
