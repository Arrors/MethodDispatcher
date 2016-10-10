//
//  ViewController.m
//  MethodDispatcher
//
//  Created by Arror on 2016/10/10.
//  Copyright © 2016年 Arror. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person  *p = [[Person   alloc] init];
    Dog     *d = [[Dog      alloc] init];
    
    APPProtocolDispatcher *dispatcher = [[APPProtocolDispatcher alloc] initWithContainer:@[p, d]];
    
    [dispatcher sayHallo];
    [dispatcher sayBye];
}

@end

@implementation Person

- (void)sayHallo {
    
    NSLog(@"Person say hallo!");
}

- (void)sayBye {
    
    NSLog(@"Person say bye!");
}

@end

@implementation Dog

- (void)sayHallo {
    
    NSLog(@"Dog say hallo!");
}

- (void)sayBye {
    
    NSLog(@"Dog say bye!");
}

@end
