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
    background,
    background_background,
    panel,
    panel_blankSurge,
    panel_shut,
    panel_P_plug,
    panel_R_plug,
    panel_Y_plug,
    panel_O_plug,
    panel_G_plug,
    panel_B_plug,
    spiral,
    spiral_background,
    spiral_R,
    spiral_O,
    spiral_Y,
    spiral_G,
    spiral_B,
    spiral_P,
    toolbox,
    toolbox_toolbox,
    
    
    // ROOM TWO...
    
    
    default_object_tag,
} ObjectTags;

typedef enum {
    
    GraphicsComponentTag,
    InputComponentTag,
    BackButtonTag,
    InfoBubbleComponentTag,
    ActivationComponentTag,
    LockComponentTag,
    AnimationComponentTag,
    InventoryBarTag,
    
} ComponentTags;

@interface Tags : NSObject

+ (ObjectTags)convertToObjectTagFromString:(NSString *)string;
+ (NSString *)convertToStringFromObjectTag:(ObjectTags)tag;


@end
