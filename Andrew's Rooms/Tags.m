//
//  Tags.m
//  Andrew's_Rooms
//
//  Created by Andrew Luke on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tags.h"
//,
//,
//panel_shut,
//panel_blankSurge,
@implementation Tags

+ (ObjectTags)convertToObjectTagFromString:(NSString *)string {
    if ([string isEqual:@"background"])
        return background;
    
    if ([string isEqual:@"background_background"])
        return background_background;
    
    if ([string isEqual:@"panel"])
        return panel;
        
    if ([string isEqual:@"panel_R_plug"])
        return panel_R_plug;
    
    if ([string isEqual:@"panel_O_plug"])
        return panel_O_plug;
    
    if ([string isEqual:@"panel_Y_plug"])
        return panel_Y_plug;
    
    if ([string isEqual:@"panel_G_plug"])
        return panel_G_plug;
    
    if ([string isEqual:@"panel_B_plug"])
        return panel_B_plug;
        
    if ([string isEqual:@"panel_P_plug"])
        return panel_P_plug;
        
    if ([string isEqual:@"panel_blankSurge"]) 
        return panel_blankSurge;
        
    if ([string isEqual:@"panel_shut"])
        return panel_shut;
        
    if ([string isEqual:@"spiral"]) 
        return spiral;
        
    if ([string isEqual:@"spiral_background"])
        return spiral_background;
    
    if ([string isEqual:@"spiral_R"])
        return spiral_R;
    
    if ([string isEqual:@"spiral_O"])
        return spiral_O;
    
    if ([string isEqual:@"spiral_Y"])
        return spiral_Y;
    
    if ([string isEqual:@"spiral_G"])
        return spiral_G;
    
    if ([string isEqual:@"spiral_B"])
        return spiral_B;
    
    if ([string isEqual:@"spiral_P"])
        return spiral_P;
    
    if ([string isEqual:@"toolbox"])
        return toolbox;
    
    if ([string isEqual:@"toolbox_toolbox"])
        return toolbox_toolbox;
    
        
    return default_object_tag;
         
}

+ (NSString *)convertToStringFromObjectTag:(ObjectTags)tag {
    
    switch (tag) {
        case background:
           return @"background";
            
        case background_background:
           return @"background_background";
        case panel:
            return @"panel";
        case panel_R_plug:
           return @"panel_R_plug";
        case panel_O_plug:
           return @"panel_O_plug";
        case panel_Y_plug:
            return @"panel_Y_plug";
        case panel_G_plug:
            return @"panel_G_plug";
        case panel_B_plug:
           return @"panel_B_plug";
        case panel_P_plug:
            return @"panel_P_plug";
        case panel_blankSurge:
            return @"panel_blankSurge";
            break;
        case panel_shut:
            return @"panel_shut";
            break;
        case spiral:
            return @"spiral";
        case spiral_background:
            return @"spiral_background";
        case spiral_R:
            return @"spiral_R";
        case spiral_O:
            return @"spiral_O";
        case spiral_Y:
            return @"spiral_Y";
        case spiral_G:
            return @"spiral_G";
        case spiral_B:
            return @"spiral_B";
        case spiral_P:
            return @"spiral_P";
        case toolbox:
            return @"toolbox";
        case toolbox_toolbox:
            return @"toolbox_toolbox";
            
        default:
            return @"INVALID OBJECT TAG";
    }
}


@end
