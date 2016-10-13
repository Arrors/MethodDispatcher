//
//  APPProtocol.h
//  MethodDispatcher
//
//  Created by Arror on 2016/10/10.
//  Copyright © 2016年 Arror. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol APPProtocol <NSObject>

- (void)sayHallo;

- (void)sayBye;

@end

@interface APPProtocolDispatcher : NSProxy<APPProtocol>

- (instancetype)initWithImplementers: (NSArray<id<APPProtocol>> *)implementers;

@end

NS_ASSUME_NONNULL_END
