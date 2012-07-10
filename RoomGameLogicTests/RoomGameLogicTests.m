//
//  RoomGameLogicTests.m
//  RoomGameLogicTests
//
//  Created by Andrew Luke on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomGameLogicTests.h"
#import "RoomLoaderTesting.h"
#import "Tags.h"
@implementation RoomGameLogicTests

- (void)setUp
{
    [super setUp];
    roomLoader = [[RoomLoaderTesting alloc] init];
    STAssertNotNil(roomLoader, @"Could not create roomLoader.");
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [roomLoader release];
    [super tearDown];
}

- (void)testGetPlistToArray
{
    [roomLoader setupTaggedRoomObjectPropertyArrayFromMap:[roomLoader readInPlistForRoom:[NSNumber numberWithInt:1]]];
    
    NSDictionary *propertyDict = roomLoader.basePropertyMap;
    NSArray *allKeys = [propertyDict allKeys];
    
    // Assert Count is correct
    STAssertEquals([propertyDict count], (NSUInteger)3, @"propertyArray count is %d not 3!!", [propertyDict count]);
    
   
    // Assert all keys at top level are correct
    for (NSNumber *numTag in allKeys) {
        NSLog(@"Object: %@", [Tags convertToStringFromObjectTag:[numTag intValue]]);
        STAssertTrue([numTag intValue] >= 0 && [numTag intValue] <= 12, @"Illegal object tag!");
    }
    
    // Assert all keys at sub level are correct
    for (NSNumber *numTag in allKeys) {
        NSArray *allSubKeys = [[propertyDict objectForKey:numTag] allKeys];
        
        for (NSNumber *subTag in allSubKeys) {
            NSLog(@"SUBObject: %@", [Tags convertToStringFromObjectTag:[subTag intValue]]);
            STAssertTrue([subTag intValue] >= 0 && [subTag intValue] <= 12, @"Illegal object tag! : %d", [subTag intValue]);
        }
    }
    
    // Assert all subObjects children are either dictionaries or strings and that total subObject children is either 2 or 4
    for (NSNumber *numTag in allKeys) {
        NSDictionary *subMap = [propertyDict objectForKey:numTag];
        NSArray *allSubKeys = [subMap allKeys];
       
        for (NSNumber *subTag in allSubKeys) {
             STAssertTrue([[subMap objectForKey:subTag] count] == 2 || [[subMap objectForKey:subTag] count] == 4, @"subMap count not equal to 2 or 4! but : %d", [subMap count]);
            
            NSDictionary *allSubSub = [subMap objectForKey:subTag];
            NSArray *allSubSubKeys = [[subMap objectForKey:subTag] allKeys];
            
            for (NSString *key in allSubSubKeys) {
                id obj = [allSubSub objectForKey:key];
                STAssertTrue([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSString class]], @"leaf class is %@, not a String or Dictionary!!", [obj class]);
                
                if ([obj isKindOfClass:[NSString class]]) {
                    STAssertEqualObjects(@"dummy", obj, @"string is not dummy, but %@!", obj);
                }
            }
        }
    }
    

//    STFail(@"Unit tests are not implemented yet in RoomGameLogicTests");
    
}

@end
