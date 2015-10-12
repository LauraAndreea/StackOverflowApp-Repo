//
//  StackoverflowAsyncRequestHelper.h
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^StackoverflowRequestCompletionBlock)(NSData* responseData);

@interface StackoverflowAsyncRequestHelper : NSObject

-(instancetype)initWithURL:(NSURL *)requestURL;
-(void)startRequestWithCompletionBlock:(StackoverflowRequestCompletionBlock)completionBlock;
-(void)cancelRequest;

@end
