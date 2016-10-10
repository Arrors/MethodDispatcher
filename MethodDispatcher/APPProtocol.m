//
//  APPProtocol.m
//  MethodDispatcher
//
//  Created by Arror on 2016/10/10.
//  Copyright © 2016年 Arror. All rights reserved.
//

#import "APPProtocol.h"
#import <objc/runtime.h>

@implementation APPProtocolDispatcher {
    
    Protocol *_protocol;
    NSArray<id<APPProtocol>> *_container;
}

- (instancetype)initWithContainer:(NSArray<id<APPProtocol>> *)container {
    
    _protocol = @protocol(APPProtocol);
    _container = container;
    
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    NSMethodSignature *signature;
    struct objc_method_description description = protocol_getMethodDescription(_protocol, sel, YES, YES);
    signature = [NSMethodSignature signatureWithObjCTypes:description.types];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL selector = invocation.selector;
    
    const char *name = sel_getName(selector);
    
    NSString *selectorName = [NSString stringWithUTF8String:name];
    
    if ([selectorName hasPrefix:@"say"]) {
        
        for (id<APPProtocol> inner in _container) {
            
            [invocation invokeWithTarget:inner];
        }
        
    } else {
        [super forwardInvocation: invocation];
    }
}

@end
