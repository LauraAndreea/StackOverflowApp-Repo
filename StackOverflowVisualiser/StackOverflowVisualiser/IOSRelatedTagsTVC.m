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
#import "QuestionRelatedTagsTVC.h"

@implementation IOSRelatedTagsTVC

#pragma mark - View Controller Lifecycle

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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = nil;
    if ([segue.identifier isEqualToString:@"Show Tag Questions"]) {
        if ([segue.destinationViewController isKindOfClass:[QuestionRelatedTagsTVC class]]) {
            indexPath = [self.tableView indexPathForSelectedRow];
            QuestionTagsTVC* tvc=(QuestionRelatedTagsTVC*)segue.destinationViewController;
            tvc.questionTag=self.tags[indexPath.row];
        }
    }
}

@end
