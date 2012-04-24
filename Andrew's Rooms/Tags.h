//
//  Tags.h
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    // ROOM ONE
    spiral,
    spiral_spiral,
    panel,
    background,
    background_background,
    panel_P_plug,
    panel_R_plug,
    panel_shut,
    panel_blankSurge,
    
    // ROOM TWO...
    
    
    
    default_object_tag,
} ObjectTags;

typedef enum {
    
    RegularState,
    CloseUpState,
    NonInteractiveState,
    
} InteractionState;



@interface Tags : NSObject

+ (ObjectTags)convertToObjectTagFromString:(NSString *)string;
+ (NSString *)convertToStringFromObjectTag:(ObjectTags)tag;


@end
