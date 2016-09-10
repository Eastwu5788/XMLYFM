//
//  NSEtcHosts.h
//  NSEtcHosts
//
//  Created by 崔 明辉 on 15/4/23.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

/**
 *  @brief  Never use NSEtcHosts in Production.
 */
@interface NSEtcHosts : NSObject

+ (void)addHost:(NSString *)host ipAddress:(NSString *)ipAddress;
+ (NSDictionary*)hostTable;
+ (NSDictionary*)ipTable;

@end



#endif
