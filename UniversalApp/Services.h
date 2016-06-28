//
//  Services.h
//  UniversalApp
//
//  Created by Rama kuppa on 26/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Services : NSObject
+ (instancetype)sharedInstance;
-(void)postmethod:(NSString*)name email:(NSString*)email;
@end
