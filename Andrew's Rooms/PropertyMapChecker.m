//
//  PropertyMapChecker.m
//  Andrew's Rooms
//
//  Created by Andrew Luke on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyMapChecker.h"

@implementation PropertyMapChecker
+ (void)assertMapHasAllRequiredObjectProperties:(NSDictionary *)map subName:(NSString*)subObjectName {

    
    NSArray *requiredProperties = [[NSArray alloc] initWithObjects:@"posX", @"posY", @"realPosX", @"realPosY", @"realWidth", @"realHeight", @"zOrder", nil];
 
    
    NSArray *allKeys = [map allKeys];
    
    for (NSString *state in allKeys) {
        id curStateObject = [map objectForKey:state];
        if ([curStateObject isKindOfClass:[NSString class]]) continue;
        NSDictionary *curStateMap = (NSDictionary *)curStateObject;
        for (NSString *reqProp in requiredProperties) {
            if (![curStateMap objectForKey:reqProp]) {
                [NSException raise:NSInternalInconsistencyException 
                            format:@"missing leaf property %@ for object %@, state: %@", reqProp, subObjectName, state];

            }
        }
    }
    
    [requiredProperties release];
    

}
@end
