//
//  NSEtcHosts.m
//  NSEtcHosts
//
//  Created by 崔 明辉 on 15/4/23.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "NSEtcHosts.h"
#import <objc/runtime.h>

#ifdef DEBUG

static NSMutableDictionary *ipTable;
static NSMutableDictionary *hostTable;
static NSMutableArray *requestStorager;

static NSMutableArray *urlChangeList;

@implementation NSURLRequest (NSEtcHosts)

- (instancetype)NEH_initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestStorager = [NSMutableArray array];
    });
    
    NSURLRequest *request = nil;
    @synchronized(self) {
        NSString *str = nil;
        for (NSString *s in urlChangeList) {
            if ([s isEqualToString:URL.absoluteString]) {
                str = s;
                break;
            }
        }
        if (str) {
            [urlChangeList removeObject:str];
            return [self NEH_initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
        }
        
        if (URL.host != nil && URL.host.length && ipTable[URL.host] != nil) {
            hostTable[ipTable[URL.host]] = URL.host;
            NSString *myURLString = URL.absoluteString;
            myURLString = [myURLString
                           stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"//%@", URL.host]
                           withString:[NSString stringWithFormat:@"//%@", ipTable[URL.host]]];
            NSURL *myURL = [NSURL URLWithString:myURLString];
            [urlChangeList addObject:myURLString];
            NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
            [requestStorager addObject:myRequest];
            
            [myRequest setValue:URL.host forHTTPHeaderField:@"Host"];
            [myRequest setValue:@"YES" forHTTPHeaderField:@"user_info"];
            request = myRequest;
            
        } else if(URL.host != nil && URL.host.length && hostTable[URL.host] != nil) {
            NSString *myURLString = URL.absoluteString;
            NSURL *myURL = [NSURL URLWithString:myURLString];
            [urlChangeList addObject:myURLString];
            NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
            [requestStorager addObject:myRequest];
            
            [myRequest setValue:hostTable[URL.host] forHTTPHeaderField:@"Host"];
            [myRequest setValue:@"YES" forHTTPHeaderField:@"user_info"];
            request = myRequest;
        } else {
            request = [self NEH_initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
        }
        return  request;
    }
}

@end


@interface NSMutableURLRequest (MyMutableURLRequest)

@end

@implementation NSMutableURLRequest (MyMutableURLRequest)

- (void)newSetValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
{
    if (nil == [self.allHTTPHeaderFields objectForKey:@"Host"]) {
        if (hostTable[self.URL.absoluteString]) {
            [self newSetValue:hostTable[self.URL.absoluteString] forHTTPHeaderField:@"Host"];
        }
    }
    [self newSetValue:value forHTTPHeaderField:field];
}

@end

@implementation NSEtcHosts

+ (void)load {
    {
        Method ori_Method = class_getInstanceMethod([NSURLRequest class], @selector(initWithURL:cachePolicy:timeoutInterval:));
        Method my_Method = class_getInstanceMethod([NSURLRequest class], @selector(NEH_initWithURL:cachePolicy:timeoutInterval:));
        method_exchangeImplementations(ori_Method, my_Method);
        
        
        Method ori_Method2 = class_getInstanceMethod([NSMutableURLRequest class], @selector(setValue:forHTTPHeaderField:));
        Method my_Method2 = class_getInstanceMethod([NSMutableURLRequest class], @selector(newSetValue:forHTTPHeaderField:));
        method_exchangeImplementations(ori_Method2, my_Method2);
    }
    
    hostTable = [NSMutableDictionary new];
    urlChangeList = [NSMutableArray new];
    ipTable = [NSMutableDictionary new];
}

+ (void)addHost:(NSString *)host ipAddress:(NSString *)ipAddress {
    [ipTable setObject:ipAddress forKey:host];
}

+ (NSDictionary *)hostTable {
    return hostTable;
}

+ (NSDictionary *)ipTable {
    return ipTable;
}

@end




#endif