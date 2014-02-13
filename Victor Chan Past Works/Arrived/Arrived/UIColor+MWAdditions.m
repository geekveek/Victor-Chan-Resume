//
//  UIColor+MWAdditions.m
//  Bonds
//
//  Created by Matthew Cheok on 4/3/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "UIColor+MWAdditions.h"

@implementation UIColor (MWAdditions)

+ (UIColor *)eastWestLineColor {
    return [UIColor colorFromWebColorString:@"#14963D"];
}

+ (UIColor *)northSouthLineColor {
    return [UIColor colorFromWebColorString:@"#E20006"];
}

+ (UIColor *)northEastLineColor {
    return [UIColor colorFromWebColorString:@"#900097"];
}

+ (UIColor *)circleLineColor {
    return [UIColor colorFromWebColorString:@"#D77107"];
}

+ (UIColor *)niceDarkColor {
    return [UIColor colorFromWebColorString:@"#37352C"];
}

+ (UIColor *)niceBackgroundColor {
    return [UIColor colorFromWebColorString:@"#CCD9C5"];
}

+ (UIColor *)niceDarkBackgroundColor {
    return [UIColor colorFromWebColorString:@"#B7C1B0"];
}

+ (UIColor *)niceRedColor {
    return [UIColor colorWithRed:247/255.f green:153/255.f blue:141/255.f alpha:1.f];
}

+ (UIColor *)niceDarkRedColor {
    return [UIColor colorWithRed:255/255.f green:67/255.f blue:47/255.f alpha:1.f];
}

+ (UIColor *)niceBlueColor {
    return [UIColor colorWithRed:120/255.f green:200/255.f blue:245/255.f alpha:1.f];
}

+ (UIColor *)niceDarkBlueColor {
    return [UIColor colorWithRed:0/255.f green:162/255.f blue:255/255.f alpha:1.f];
}

#pragma mark -
#pragma mark WebColor


- (NSString *)webColorString {
	
	if (![self canProvideRGBColor]) return nil;
	
	return [NSString stringWithFormat:@"#%02X%02X%02X", ((NSUInteger)([self redComponent] * 255)),
			((NSUInteger)([self greenComponent] * 255)), ((NSUInteger)([self blueComponent] * 255))];
	
}

+ (UIColor *)colorFromWebColorString: (NSString *)colorString {
    
	NSUInteger length = [colorString length];
	if (length > 0) {
		// remove prefixed #
		colorString = [colorString stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"#"]];
		length = [colorString length];
		
		// calculate substring ranges of each color
		// FFF or FFFFFF
		NSRange redRange, blueRange, greenRange;
		if (length == 3) {
			redRange = NSMakeRange(0, 1);
			greenRange = NSMakeRange(1, 1);
			blueRange = NSMakeRange(2, 1);
		} else if (length == 6) {
			redRange = NSMakeRange(0, 2);
			greenRange = NSMakeRange(2, 2);
			blueRange = NSMakeRange(4, 2);
		} else {
			return nil;
		}
        
		// extract colors
		NSUInteger redComponent, greenComponent, blueComponent;
		BOOL valid = YES;
		NSScanner *scanner = [NSScanner scannerWithString:[colorString substringWithRange:redRange]];
		valid = [scanner scanHexInt:&redComponent];
		
		scanner = [NSScanner scannerWithString:[colorString substringWithRange:greenRange]];
		valid = ([scanner scanHexInt:&greenComponent] && valid);
        
		scanner = [NSScanner scannerWithString:[colorString substringWithRange:blueRange]];
		valid = ([scanner scanHexInt:&blueComponent] && valid);
        
		if (valid) {
			return [UIColor colorWithRed:redComponent/255.0 green:greenComponent/255.0 blue:blueComponent/255.0 alpha:1.0f];
		}
	}
	
	return nil;
}


#pragma mark -
#pragma mark String

- (NSString *)stringFromColor {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	
	NSString *result;
	switch ([self colorSpaceModel]) {
		case kCGColorSpaceModelRGB:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", [self redComponent], [self greenComponent], [self blueComponent], [self alphaComponent]];
			break;
		case kCGColorSpaceModelMonochrome:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", [self whiteComponent], [self alphaComponent]];
			break;
		default:
			result = nil;
	}
	return result;
}

+ (UIColor *)colorFromString: (NSString *)colorString {
	NSScanner *scanner = [NSScanner scannerWithString:colorString];
	if (![scanner scanString:@"{" intoString:NULL]) return nil;
	const NSUInteger kMaxComponents = 4;
	CGFloat c[kMaxComponents];
	NSUInteger i = 0;
	if (![scanner scanFloat:&c[i++]]) return nil;
	while (1) {
		if ([scanner scanString:@"}" intoString:NULL]) break;
		if (i >= kMaxComponents) return nil;
		if ([scanner scanString:@"," intoString:NULL]) {
			if (![scanner scanFloat:&c[i++]]) return nil;
		} else {
			// either we're at the end of there's an unexpected character here
			// both cases are error conditions
			return nil;
		}
	}
	if (![scanner isAtEnd]) return nil;
	UIColor *color;
	switch (i) {
		case 2: // monochrome
			color = [UIColor colorWithWhite:c[0] alpha:c[1]];
			break;
		case 4: // RGB
			color = [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[3]];
			break;
		default:
			color = nil;
	}
	return color;
}




#pragma mark -
#pragma mark Propery List

+ (UIColor *)colorFromPropertyRepresentation:(id)colorObject
{
	UIColor *color = nil;
	if ([colorObject isKindOfClass:[NSString class]]) {
		color = [UIColor colorFromString:colorObject];
		if (!color) {
			color = [UIColor colorFromWebColorString:colorObject];
		}
	} else if ([colorObject isKindOfClass:[NSData class]]) {
		color = [NSKeyedUnarchiver unarchiveObjectWithData:colorObject];
	} else if ([colorObject isKindOfClass:[UIColor class]]){
		color = colorObject;
	}
	return color;
}

- (id)propertyRepresentation
{
	NSString *colorString = [self stringFromColor];
	if (colorString) return colorString;
	
	return nil;
}


#pragma mark -
#pragma mark RGB

- (UIColor *)colorInRGBColorSpace {
    if ([self canProvideRGBColor]) {
        return [UIColor colorWithRed:[self redComponent] green:[self greenComponent] blue:[self blueComponent] alpha:[self alphaComponent]];
    }
    return nil;
}

// The RGB code is based on:
// http://arstechnica.com/apple/guides/2009/02/iphone-development-accessing-uicolor-components.ars

- (BOOL)canProvideRGBColor {
	return (([self colorSpaceModel] == kCGColorSpaceModelRGB) || ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));
}

- (CGColorSpaceModel)colorSpaceModel {
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (CGFloat)redComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)greenComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[1];
}

- (CGFloat)blueComponent {
	NSAssert ([self canProvideRGBColor], @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[2];
}

- (CGFloat)alphaComponent {
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[CGColorGetNumberOfComponents(self.CGColor)-1];
}

- (CGFloat)whiteComponent {
	NSAssert([self colorSpaceModel] == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

#pragma mark -
#pragma mark HSV

// conversion: http://en.wikipedia.org/wiki/HSL_and_HSV
// calculates HSV values

- (CGFloat)hueComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];
	
	CGFloat min = MIN(MIN(r,g),b);
	CGFloat max = MAX(MAX(r,g),b);
	
	CGFloat hue = 0;
	if (max==min) {
		hue = 0;
	} else if (max == r) {
		hue = fmod((60 * (g-b)/(max-min) + 360), 360);
	} else if (max == g) {
		hue = (60 * (b-r)/(max-min) + 120);
	} else if (max == b) {
		hue = (60 * (r-g)/(max-min) + 240);
	}
	return hue / 360;
}


- (CGFloat)saturationComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];
	
	CGFloat min = MIN(MIN(r,g),b);
	CGFloat max = MAX(MAX(r,g),b);
	
	if (max==0) {
		return 0;
	} else {
		return (max-min)/(max);
	}
}

- (CGFloat)brightnessComponent {
	if (![self canProvideRGBColor]) return 0;
	CGFloat r = [self redComponent];
	CGFloat g = [self greenComponent];
	CGFloat b = [self blueComponent];
	
	CGFloat max = MAX(MAX(r,g),b);
	
	return max;
}


#pragma mark - Texture

- (UIColor *)colorWithTextureOnImage:(UIImage *)image
{
    CGSize imageSize = image.size;
    CGRect drawRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContext(imageSize);
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, drawRect);
    
    // blend texture on top
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGImageRef cgImage = image.CGImage;
    CGContextDrawImage(context, drawRect, cgImage);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    
    UIColor *texturedColor = [UIColor colorWithPatternImage:textureImage];
    return texturedColor;
}


#pragma mark - Derived Colors

- (UIColor *)darkenedColor
{
    CGFloat delta = 0.1f;
    if (![self canProvideRGBColor]) return self;
    
    CGFloat redComponent = MAX([self redComponent]-delta,0);
    CGFloat greenComponent = MAX([self greenComponent]-delta,0);
    CGFloat blueComponent = MAX([self blueComponent]-delta,0);
    CGFloat alphaComponent = [self alphaComponent];
    
    UIColor *darkenedColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    return darkenedColor;
}

- (UIColor *)lightenedColor
{
    CGFloat delta = 0.1f;
    if (![self canProvideRGBColor]) return self;
    
    CGFloat redComponent = MIN([self redComponent]+delta,1);
    CGFloat greenComponent = MIN([self greenComponent]+delta,1);
    CGFloat blueComponent = MIN([self blueComponent]+delta,1);
    CGFloat alphaComponent = [self alphaComponent];
    
    UIColor *lightenedColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    return lightenedColor;
}

@end
