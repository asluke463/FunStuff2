//
//  GraphicsComponent.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsComponent.h"

@implementation GraphicsComponent
@synthesize position, scale, zOrder, trueRect, gameObject;




- (void)Receive:(SignalID)signal {
    
    [NSException raise:NSInternalInconsistencyException 
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}
/*======
 init with sprite array and set first sprite as displayed
 =======*/

//- (id)initWithGameObject:(GameObject *)gameObj {
//    
//    if ((self = [super init])) {
////        self.sprites = [[CCArray alloc] initWithArray:spriteArray];
//        // set initial display sprite and display that
//        if ([gameObj isKindOfClass:[RoomObject class]]) {
//            self.gameObject = (RoomObject *)gameObj;
//            self.objectName = [self.gameObject objectBaseName];
//        } else if ([gameObj isKindOfClass:[RoomSubObject class]]) {
//            self.gameObject = (RoomSubObject *)gameObj;
//            self.objectName = [self.gameObject subObjectName];
//        }
//        
//
//        self.baseObjectMap = [[NSDictionary alloc] initWithDictionary:[[RoomScene sharedRoomScene].roomLoader.objectPropertyListForCurrentRoom objectForKey:self.objectName]];
//        
//        NSArray *objectNameKeys = [[NSArray alloc] initWithArray:[baseObjectMap allKeys]];
//        
//        for (NSString *objectName in objectNameKeys) {
//            [self addSpritesToSelfFromPlist:baseName objectName:objectName];
//        }
//        
//        [objectNameKeys release];
//    }
//    
//    return self;
//}
//
//+ (id)graphicsComponentWithGameObject:(GameObject *)gameObj {
//    
//    return [[[self alloc] initWithGameObject:gameObj] autorelease];
//}



//- (void)addSpritesToSelfFromPlist:(NSString *)baseName objectName:(NSString *)objectName {
//    
//    if ([[baseObjectMap objectForKey:objectName] isKindOfClass:[NSArray class]]) {
//        NSString *spriteFrameName = [[NSString alloc] initWithFormat:@"%@_%@", baseName, objectName];
//        
//        NSArray *frameDataArray = [[NSArray alloc] initWithArray:[baseObjectMap objectForKey:objectName]];
//        
//        for (NSDictionary *propertyMap in frameDataArray) {
//            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
//            sprite.position = CGPointMake([(NSNumber *)[propertyMap objectForKey:@"posX"] floatValue], [(NSNumber *)[propertyMap objectForKey:@"posY"] floatValue]);
//            
//            [self.gameObject addChild:sprite z:[(NSNumber *)[propertyMap objectForKey:@"zOrder"] intValue] tag:[Tags convertToObjectTagFromString:spriteFrameName]];
//
//            // need to set touchDetectionRect
////            self.touchDetectionRect = CGRectMake(([(NSNumber *)[propertyMap objectForKey:@"realPosX"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realPosY"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realWidth"] floatValue]), ([(NSNumber *)[propertyMap objectForKey:@"realHeight"] floatValue]));
////            
////            if ((self.touchDetectionRect.size.width*self.touchDetectionRect.size.height) > (parent.touchDetectionRect.size.width * parent.touchDetectionRect.size.height)) {
////                [parent updateDetectionRect:self.touchDetectionRect];
////            }
//
//        }
//
//
//        //        [ObjectSprite spriteWithParent:self spriteFrameName:spriteFrameName frameArray:frameDataArray];
//        [frameDataArray release];
//        [spriteFrameName release];
//        
//    }
//    
//}
//
//
//- (id)initWithGameObjectBaseName:(NSString *)baseName {
//    
//    if ((self = [super init])) {
//        //        self.sprites = [[CCArray alloc] initWithArray:spriteArray];
//
//        // set initial display sprite and display that
//        
//        self.baseObjectMap = [[NSDictionary alloc] initWithDictionary:[[RoomScene sharedRoomScene].roomLoader.objectPropertyListForCurrentRoom objectForKey:baseName]];
//        
//        NSArray *objectNameKeys = [[NSArray alloc] initWithArray:[baseObjectMap allKeys]];
//        
//        for (NSString *objectName in objectNameKeys) {
//            [self addSpritesToSelfFromPlist:baseName objectName:objectName];
//        }
//        
//        [objectNameKeys release];
//    }
//    
//    return self;
//}
//
//+ (id)graphicsComponentWithGameObjectBaseName:(NSString *)baseName {
//    
//    return [[[self alloc] initWithGameObjectBaseName:baseName] autorelease];
//}
//
//- (CGRect)getCurrentDetectionRect {
//    
//    return CGRectMake(50, 50, 50, 50);  
//}


- (void)dealloc
{
    [gameObject release];
    [super dealloc];
}

@end
