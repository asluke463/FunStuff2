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
    
    if ([string isEqual:@"spiral"]) 
         return spiral;
    else if ([string isEqual:@"spiral_spiral"]) {
        return spiral_spiral;
    } else if ([string isEqual:@"panel"]) {
        return panel;
    } else if ([string isEqual:@"background"]) {
        return background;
    } else if ([string isEqual:@"background_background"]) {
        return background_background;
    } else if ([string isEqual:@"panel_P_plug"]) {
        return panel_P_plug;
    } else if ([string isEqual:@"panel_R_plug"]) {
        return panel_R_plug;
    } else if ([string isEqual:@"panel_blankSurge"]) {
        return panel_blankSurge;
    } else if ([string isEqual:@"panel_shut"]) {
        return panel_shut;
    } else {
        return default_object_tag;
    }
         
}

+ (NSString *)convertToStringFromObjectTag:(ObjectTags)tag {
    
    return @"";
}

@end
