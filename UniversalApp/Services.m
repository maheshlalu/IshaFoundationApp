//
//  Services.m
//  UniversalApp
//
//  Created by Rama kuppa on 26/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

#import "Services.h"

@implementation Services

+ (instancetype)sharedInstance
{
    static Services *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Services alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}
-(void)postmethod:(NSString*)name email:(NSString*)email
{
    NSString * appType =@"test";
    NSString * deviceID = [self uuid];
    
    NSString *post = [NSString stringWithFormat:@"apitype=%@&name=%@&email=%@&appType=%@&devid=%@",@"ADDUSER",name,email,appType,deviceID];
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.ishafoundation.org/us/ikapp/ikAppApi.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);

    }] resume];
    

    
    
}
@end
