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
#import "QuestionTagsTVC.h"

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

-(void)fetchQuestions :(NSString *)questionTag
{
    NSURL *searchQuestionURL =[StackExchange URLForSearch:questionTag];
    self.questions = [[NSMutableArray alloc]init];
    StackoverflowAsyncRequestHelper *asyncRequest = [[StackoverflowAsyncRequestHelper alloc]initWithURL: searchQuestionURL];
    dispatch_async(dispatch_get_main_queue(), ^{
        [asyncRequest startRequestWithCompletionBlock:^(NSData *responseData) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                options:0
                                                                                  error:NULL];
            NSArray *items = [propertyListResults valueForKeyPath:STACK_EXCHANGE_ITEMS];
            for (NSDictionary *item in items) {
                Question *question  = [[Question alloc]init];
                question.questionId = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_ID];
                question.titleOfQuestion = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_TITLE];
                NSLog(@" %@",question);
                [self.questions addObject:question];
            }
        }];
        
    });
    
    
}

#pragma mark - Navigation

- (void)prepareViewController:(id)vc
                     forSegue:(NSString *)segueIdentifer
                fromIndexPath:(NSIndexPath *)indexPath
{
    if ([vc isKindOfClass:[QuestionTagsTVC class]]) {
        [self fetchQuestions:self.tags[indexPath.row]];
        QuestionTagsTVC *qvc = (QuestionTagsTVC *)vc;
        qvc.questions = self.questions;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForSelectedRow];
        [self prepareViewController:segue.destinationViewController
                           forSegue:segue.identifier
                      fromIndexPath:indexPath];
    }
 
}

@end
