//
//  NSObject+GSCategory.h
//  WednoteApp
//
//  Created by Geeks on 20/9/14.
//  Copyright (c) 2014 Wednote Online Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface NSObject (GSCategory)

- (NSString *) getServerReply:(NSString *)methodType :(NSString *)add1 :(NSString *)add2 :(NSString *)add3;

- (NSString *)readStringFromFile:(NSString *)pFilename;
- (CGFloat)screenWidth;
- (CGFloat)screenHeight;
- (CGFloat)statusBarHeight;
- (int)screenDPI;
- (void) cacheImage:(NSString *)ImageURLString;
- (UIImage *) getCachedImage: (NSString *) ImageURLString;
- (NSString *) stringByStrippingHTML;
- (UIImage*) createImageWithColor: (UIColor*) color;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;
@end
