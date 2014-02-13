//
//  UIColor+MWAdditions.h
//  Bonds
//
//  Created by Matthew Cheok on 4/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MWAdditions)

+ (UIColor *)eastWestLineColor;
+ (UIColor *)northSouthLineColor;
+ (UIColor *)northEastLineColor;
+ (UIColor *)circleLineColor;

+ (UIColor *)niceDarkColor;
+ (UIColor *)niceBackgroundColor;
+ (UIColor *)niceDarkBackgroundColor;
+ (UIColor *)niceRedColor;
+ (UIColor *)niceDarkRedColor;
+ (UIColor *)niceBlueColor;
+ (UIColor *)niceDarkBlueColor;

#pragma mark -
#pragma mark Web String

- (NSString *)webColorString;
+ (UIColor *)colorFromWebColorString: (NSString *)colorString;

#pragma mark -
#pragma mark String

- (NSString *)stringFromColor;
+ (UIColor *)colorFromString: (NSString *)colorString;

#pragma mark -
#pragma mark Propery List

+ (UIColor *)colorFromPropertyRepresentation:(id)colorObject;
- (id)propertyRepresentation ;

#pragma mark -
#pragma mark RGB


- (UIColor *)colorInRGBColorSpace;
- (BOOL)canProvideRGBColor;
- (CGColorSpaceModel)colorSpaceModel;
- (CGFloat)redComponent;
- (CGFloat)greenComponent;
- (CGFloat)blueComponent;
- (CGFloat)alphaComponent;
- (CGFloat)whiteComponent;


#pragma mark -
#pragma mark HSB

- (CGFloat)hueComponent;
- (CGFloat)saturationComponent;
- (CGFloat)brightnessComponent;


#pragma mark - Texture

- (UIColor *)colorWithTextureOnImage:(UIImage *)image;


#pragma mark - Derived Colors

- (UIColor *)darkenedColor;
- (UIColor *)lightenedColor;

@end
