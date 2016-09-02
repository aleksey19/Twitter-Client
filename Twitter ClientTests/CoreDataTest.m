//
//  CoreDataTest.m
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"

SPEC_BEGIN(CoreDataTest)

describe(@"sum", ^{
    context(@"with 2 numbers", ^{
        it(@"returns the sum of the two numbers", ^{
            [[@(40 + 2) should] equal:@42];
        });
    });
});

SPEC_END