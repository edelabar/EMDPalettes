//
//  EMDPalettesTests.m
//  EMDPalettesTests
//
//  Created by Eric DeLabar on 2/1/15.
//  Copyright (c) 2015 EricDeLabar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "UIColor+EMDPalettes.h"

@interface EMDPalettesTests : XCTestCase

@end

@implementation EMDPalettesTests

- (void)testColorFound {
    UIColor *color = [UIColor colorNamed:@"EMDPalettesTest.Grape"];
    
    XCTAssertNotNil(color,"Color should be defined.");
}

- (void)testColorIsCorrect {
    UIColor *color = [UIColor colorNamed:@"EMDPalettesTest.Grape"];
    
    CGFloat red, green, blue, alpha;
    BOOL success = [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    XCTAssertTrue(success,"Color components were not successfully read.");
    XCTAssertEqualWithAccuracy(red * 255, 128, 0.00001);
    XCTAssertEqualWithAccuracy(green * 255, 0, 0.00001);
    XCTAssertEqualWithAccuracy(blue * 255, 255, 0.00001);
    XCTAssertEqualWithAccuracy(alpha * 255, 255, 0.00001);
}

@end
