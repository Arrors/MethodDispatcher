//
//  ViewController.h
//  MethodDispatcher
//
//  Created by Arror on 2016/10/10.
//  Copyright © 2016年 Arror. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APPProtocol.h"

@interface ViewController : UIViewController

@end

@interface Person : NSObject<APPProtocol>

@end

@interface Dog : NSObject<APPProtocol>

@end

