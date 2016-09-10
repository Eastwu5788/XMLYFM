//
//  MyURLCache.m
//  WebCache
//
//  Created by Song on 12-9-29.
//  Copyright (c) 2013年 axs. All rights reserved.
//

#import "MyURLCache.h"
#include <CommonCrypto/CommonDigest.h>

static NSString *cacheDirectory;
static NSSet *supportSchemes;

@implementation MyURLCache
@synthesize cachedResponses,responsesInfo;

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
    NSLog(@"removeCachedResponseForRequest:%@",request.URL.absoluteString);
    [cachedResponses removeObjectForKey:request.URL.absoluteString];
    [super removeCachedResponseForRequest:request];
}

- (void)removeAllCachedResponses {
    NSLog(@"removeAllObjects");
    [cachedResponses removeAllObjects];
    [super removeAllCachedResponses];
}

+ (void)initialize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    cacheDirectory = [paths objectAtIndex:0];
    supportSchemes = [NSSet setWithObjects:@"http", @"https", @"ftp", nil];
}

- (void)saveInfo {
    if ([responsesInfo count]) {
        NSString *path = [cacheDirectory stringByAppendingString:@"Info.plist"];
        [responsesInfo writeToFile:path atomically:YES];
    }
}

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path {
    if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        cachedResponses = [[NSMutableDictionary alloc]init];
        NSString *path = [cacheDirectory stringByAppendingString:@"Info.plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            responsesInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        }else{
            responsesInfo = [[NSMutableDictionary alloc]init];
        }
    }
    return self;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame)
    {
        return [super cachedResponseForRequest:request];
    }
    
    NSURL *url = request.URL;
    if (![supportSchemes containsObject:url.scheme])
    {
        return [super cachedResponseForRequest:request];
    }
    
    
    NSString *absoluteString = url.absoluteString;
//    NSLog(@"absoluteString = %@\n", absoluteString);
   __block NSCachedURLResponse *cachedResponse = [cachedResponses objectForKey:absoluteString];
    if (cachedResponse)
    {
//        NSLog(@"cached: %@\n", absoluteString);
        return cachedResponse;
    }
    
   __block NSDictionary *responseInfo = [responsesInfo objectForKey:absoluteString];
    if (responseInfo)
    {
        NSString *path = [cacheDirectory stringByAppendingString:[responseInfo objectForKey:@"filename"]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path])
        {

            NSData *data = [NSData dataWithContentsOfFile:path];
            
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:[responseInfo objectForKey:@"MIMEType"] expectedContentLength:data.length textEncodingName:nil];
            cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            
            [cachedResponses setObject:cachedResponse forKey:absoluteString];
            return cachedResponse;
        }
    }
    
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:request.timeoutInterval];
    newRequest.allHTTPHeaderFields = request.allHTTPHeaderFields;
    newRequest.HTTPShouldHandleCookies = request.HTTPShouldHandleCookies;
   
    //ios5.0以上timeout
   // NSData *data = [NSURLConnection sendSynchronousRequest:newRequest returningResponse:&response error:&error];
    [NSURLConnection sendAsynchronousRequest:newRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error){
        if (error) {
//            NSLog(@"cache error : %@", error);
//            NSLog(@"not cached: %@", request.URL.absoluteString);
            cachedResponse = nil;
        }
        uint8_t digest[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1(data.bytes, data.length, digest);
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];
        
        NSString *filename = output;
        NSString *path = [cacheDirectory stringByAppendingString:filename];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:path contents:data attributes:nil];
        
        
        NSURLResponse *newResponse = [[NSURLResponse alloc] initWithURL:response.URL MIMEType:response.MIMEType expectedContentLength:data.length textEncodingName:nil];
        responseInfo = [NSDictionary dictionaryWithObjectsAndKeys:filename, @"filename", newResponse.MIMEType, @"MIMEType", nil];
        [responsesInfo setObject:responseInfo forKey:absoluteString];

    }];

    return cachedResponse;

}

@end
