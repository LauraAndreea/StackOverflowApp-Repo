//
//  IOSRelatedTagsTVC.m
//  StackOverflowVisualiser
//
//  Created by Madalina Melinte on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "IOSRelatedTagsTVC.h"
#import "StackoverflowAsyncRequestHelper.h"
#import "StackExchange.h"
@implementation IOSRelatedTagsTVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTags];
}

-(void)fetchTags
{
    NSURL *url = [StackExchange URLForRelatedTags];
    StackoverflowAsyncRequestHelper* stackoverflowAsyncRequestHelper= [[StackoverflowAsyncRequestHelper alloc] initWithURL:url];
    [stackoverflowAsyncRequestHelper startRequestWithCompletionBlock:^(NSData *responseData) {
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:responseData
                                                                            options:0
                                                                              error:NULL];
        self.tags=[propertyListResults valueForKeyPath:STACK_EXCHANGE_ITEMS_NAME];
        NSLog(@" %@",propertyListResults);
    }];
}
@end
