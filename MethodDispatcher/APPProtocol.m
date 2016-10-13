//
//  APPProtocol.m
//  MethodDispatcher
//
//  Created by Arror on 2016/10/10.
//  Copyright © 2016年 Arror. All rights reserved.
//

#import "APPProtocol.h"
#import <objc/runtime.h>

struct objc_method_description methodDescriptionForSELInProtocol(Protocol *protocol, SEL sel) {
    
    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
    
    if (description.types) {
        
        return description;
    }
    
    description = protocol_getMethodDescription(protocol, sel, NO, YES);
    
    if (description.types) {
        
        return description;
    }
    
    return (struct objc_method_description){NULL, NULL};
}

BOOL protocolContainSel(Protocol *protocol, SEL sel) {
    
    return methodDescriptionForSELInProtocol(protocol, sel).types ? YES : NO;
}

NSMethodSignature* methodSignatureForSelector(SEL sel, Protocol *protocol) {
    
    NSMethodSignature *signature;
    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
    signature = [NSMethodSignature signatureWithObjCTypes:description.types];
    return signature;
}

@implementation APPProtocolDispatcher {
    
    Protocol *_protocol;
    NSArray *_implementers;
}

- (instancetype)initWithImplementers:(NSArray<id<APPProtocol>> *)implementers {
    
    _protocol = @protocol(APPProtocol);
    _implementers = implementers;
    
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return methodSignatureForSelector(sel, _protocol);
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL selector = invocation.selector;
    
    if (!protocolContainSel(_protocol, selector)) {
        
        [super forwardInvocation:invocation];
        
        return;
    }
    
    for (id implemente in _implementers) {
        
        if ([implemente respondsToSelector:selector]) {
            
            [invocation invokeWithTarget:implemente];
        }
    }
}

@end
