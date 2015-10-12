//
//  StackoverflowAsyncRequestHelper.m
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "StackoverflowAsyncRequestHelper.h"

@interface StackoverflowAsyncRequestHelper()
{
    StackoverflowRequestCompletionBlock _completionHandler;
    NSString *_stringURL;
    NSData *_dataFromURL;
    NSURLSessionDataTask *_dataTask;
}
@end

@implementation StackoverflowAsyncRequestHelper

-(instancetype)initWithURL:(NSString *)stringURL
{
    self = [super init];
    if (self) {
        _stringURL = stringURL;
    }
    return self;
}

-(void)startRequestWithCompletionBlock:(StackoverflowRequestCompletionBlock)completionBlock
{
    _completionHandler = completionBlock;
    [self startRequestWithUrl:_stringURL];
}

-(void)startRequestWithUrl:(NSString *)stringUrl
{
    NSURL * url = [[NSURL alloc]initWithString:stringUrl];
    NSURLSession * session = [NSURLSession sharedSession];
    _dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                 {
                     [self executeBlock:data];
                 }];
    [_dataTask resume];
    
}

-(void)executeBlock:(NSData *)data
{
    if (_completionHandler != nil) {
        _completionHandler(data);
        _completionHandler = nil;
    }
    
}
-(void)cancelRequest
{
    _completionHandler = nil;
    [_dataTask cancel];
}

@end
