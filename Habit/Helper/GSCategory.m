//
//  NSObject+GSCategory.m
//  WednoteApp
//
//  Created by Geeks on 20/9/14.
//  Copyright (c) 2014 Wednote Online Limited. All rights reserved.
//

#import "GSCategory.h"


@implementation NSObject (GSCategory)

- (NSString *) getServerReply:(NSString *)methodType :(NSString *)add1 :(NSString *)add2 :(NSString *)add3
{
    NSString *comID=@"sAo62bDS7DW7pLEJQYe2T1ORhFL42lKO7yYa6CzdK3ZstLHSBEsctt98WwFY0jXl";
    NSString *askMsg=@"iamanapple";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.wednote.com.hk/wedding/communicate"]];
    [request setHTTPMethod:@"POST"];
    
    NSString* userUpdate = nil;
    if (add1 == nil) {
        userUpdate =[[NSString alloc] initWithFormat:@"comID=%@&askMsg=%@&actionCMD=%@", comID, askMsg, methodType];
    } else {
        userUpdate =[[NSString alloc] initWithFormat:@"comID=%@&askMsg=%@&actionCMD=%@&additional=%@", comID, askMsg, methodType, add1];
    }

    //NSLog(@"the data Details is =%@", userUpdate);
    NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    NSError *err;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
    //NSLog(@"Got Response==%@", resSrt);
    if(resSrt) {
        //NSLog(@"got response");
    } else {
        NSLog(@"faield to connect");
    }
    //NSLog(@"%@", resSrt);
    return resSrt;
}

+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize+4;
    if (text) {
        CGSize size;
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);

        result = MAX(size.height, result); //At least one row
    }
    return result;
}

- (NSString *)readStringFromFile:(NSString *)pFilename
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = pFilename;
    NSString *fileAtPath = [filePath stringByAppendingString:fileName];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

- (CGFloat)screenWidth {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    return screenSize.width;
}

- (CGFloat)screenHeight {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    return screenSize.height;
}

-(CGFloat)statusBarHeight{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}



- (int)screenDPI {
    NSLog(@"%f",[[UIScreen mainScreen] scale]);
    int dpi = 0;
    if((int)[[UIScreen mainScreen] scale]==1){
        dpi = 163;
    }else if((int)[[UIScreen mainScreen] scale]==2){
        dpi = 316;
    }else {
        dpi = 401;
    }
    return dpi;
}

- (void) cacheImage:(NSString *)ImageURLString;
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    NSString* lastPath = [[NSString alloc] init];
    NSArray* pathComponents = [ImageURLString pathComponents];
    long intPathCnt = [pathComponents count];
    if (intPathCnt >= 2)
    {
        lastPath = pathComponents[intPathCnt - 2];
    }
    
    //NSLog(@"%@", lastPath);
    
    // Generate a unique path to a resource representing the image you want
    NSString *docPath = [NSString stringWithFormat:@"Documents/%@", lastPath];
    NSString *docPath2 = [NSHomeDirectory() stringByAppendingPathComponent:docPath];
    NSString *filename = [ImageURLString lastPathComponent];
    NSString *uniquePath = [docPath2 stringByAppendingPathComponent: filename];
    
    // Check for file existence
    
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath2 isDirectory:&isDir])
    {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:docPath2 withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // Fetch image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        //image = [self roundCorners: image];
        
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: NO];
        }
        else if(
                [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound ||
                [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
                )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: NO];
        }
    }
}

- (UIImage *) getCachedImage: (NSString *) ImageURLString
{
    NSString* lastPath = [[NSString alloc] init];
    NSArray* pathComponents = [ImageURLString pathComponents];
    long intPathCnt = [pathComponents count];
    if (intPathCnt >= 2)
    {
        lastPath = pathComponents[intPathCnt - 2];
    }
    
    // Generate a unique path to a resource representing the image you want
    NSString *docPath = [NSString stringWithFormat:@"Documents/%@", lastPath];
    NSString *docPath2 = [NSHomeDirectory() stringByAppendingPathComponent:docPath];
    NSString *filename = [ImageURLString lastPathComponent] ;
    NSString *uniquePath = [docPath2 stringByAppendingPathComponent: filename];
    
    UIImage *image;
    
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
    else
    {
        // get a new one
        [self cacheImage: ImageURLString];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    
    return image;
}

-(NSString *) stringByStrippingHTML {
//    NSRange r;
//    NSString *s = [self copy];
//    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
//        s = [s stringByReplacingCharactersInRange:r withString:@""];
//    return s;
    NSString *str = [self copy];
    NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                            NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)}
                                                             documentAttributes:nil
                                                                          error:nil];
    
    return attr.string;
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}



@end

