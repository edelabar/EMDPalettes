//
//  UIColor+EMDPalettes.m
//  EMDPalettes
//
//  Created by Eric DeLabar on 2/1/15.
//  Copyright (c) 2015 EricDeLabar. All rights reserved.
//

#import "UIColor+EMDPalettes.h"

static NSDictionary *palettes;
static NSMutableDictionary *colorCache;

@implementation UIColor (EMDPalettes)

+ (void)readPalettes
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        NSBundle *bundle = [NSBundle bundleForClass:[delegate class]];
        NSURL *paletteListURL = [bundle URLForResource:@"ColorPalettes" withExtension:@"plist"];
        if (paletteListURL)
        {
            palettes = [NSDictionary dictionaryWithContentsOfURL:paletteListURL];
        } else {
            palettes = [NSDictionary new];
        }
        colorCache = [[NSMutableDictionary alloc] initWithCapacity:[palettes count]];
    });
}

+ (UIColor *)colorNamed:(NSString *)colorName
{
    [UIColor readPalettes];
    
    UIColor *color = colorCache[colorName];
    if (!color) {
        
        NSArray *keys = [colorName componentsSeparatedByString:@"."];
        NSAssert([keys count] == 2,@"Provided colorName should be in format \"{Color List Name}.{Color Name}\", only one '.' is allowed.");
        
        NSDictionary *colors = palettes[keys[0]];
        NSAssert(colors, @"Provided color list name (\"%@\") in colorName (\"%@\") must exist in the ColorPalettes.plist file in your application's main bundle.",keys[0],colorName);
        
        NSDictionary *colorComponents = colors[keys[1]];
        NSAssert(colorComponents, @"Provided color name (\"%@\") in colorName (\"%@\") must exist in the ColorPalettes.plist file in your application's main bundle.",keys[1],colorName);
        
        color = [UIColor colorWithRed:[colorComponents[@"red"] floatValue]  green:[colorComponents[@"green"] floatValue] blue:[colorComponents[@"blue"] floatValue] alpha:[colorComponents[@"alpha"] floatValue]];
        colorCache[colorName] = color;
    }
    return color;
}

@end
