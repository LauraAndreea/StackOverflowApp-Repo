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

-(void)fetchQuestions :(NSString *)questionTag andTVC:(QuestionTagsTVC *)tvc
{
    NSURL *searchQuestionURL =[StackExchange URLForSearch:questionTag];
    StackoverflowAsyncRequestHelper *asyncRequest = [[StackoverflowAsyncRequestHelper alloc]initWithURL: searchQuestionURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [asyncRequest startRequestWithCompletionBlock:^(NSData *responseData) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                options:0
                                                                                  error:NULL];
            NSArray *items = [propertyListResults valueForKeyPath:STACK_EXCHANGE_ITEMS];
            self.questions = [[NSMutableArray alloc]init];
            for (NSDictionary *item in items) {
                Question *question  = [[Question alloc]init];
                question.questionId = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_ID];
                question.titleOfQuestion = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_TITLE];
                [self.questions addObject:question];
            }
            tvc.questions=self.questions;
        }];
        
    });
}

#pragma mark - Navigation

- (void)prepareViewController:(id)tvc
                     forSegue:(NSString *)segueIdentifer
                fromIndexPath:(NSIndexPath *)indexPath
{
    if ([tvc isKindOfClass:[QuestionTagsTVC class]]) {
        [self fetchQuestions:self.tags[indexPath.row] andTVC:tvc];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = nil;
    if ([segue.identifier isEqualToString:@"Show Tag Questions"]) {
        if ([segue.destinationViewController isKindOfClass:[QuestionTagsTVC class]]) {
            indexPath = [self.tableView indexPathForSelectedRow];
            [self prepareViewController:segue.destinationViewController
                               forSegue:segue.identifier
                          fromIndexPath:indexPath];}
        
    }
}

@end
