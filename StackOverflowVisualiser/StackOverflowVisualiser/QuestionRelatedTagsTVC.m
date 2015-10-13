//
//  QuestionRelatedTagsTVC.m
//  StackOverflowVisualiser
//
//  Created by Madalina Melinte on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "QuestionRelatedTagsTVC.h"
#import "StackoverflowAsyncRequestHelper.h"
#import "StackExchange.h"
#import "AnswersForQuestionRelatedTagsTVC.h"
#import "AnswersForQuestionTagsTVC.h"

@implementation QuestionRelatedTagsTVC

#pragma mark - View Controller Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchQuestions];
}

-(void)fetchQuestions
{
    NSURL *searchQuestionURL =[StackExchange URLForSearch:self.questionTag];
    NSMutableArray<Question *>  *questions=[[NSMutableArray alloc]init];
    StackoverflowAsyncRequestHelper *asyncRequest = [[StackoverflowAsyncRequestHelper alloc]initWithURL: searchQuestionURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [asyncRequest startRequestWithCompletionBlock:^(NSData *responseData) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                options:0
                                                                                  error:NULL];
            NSLog(@"P%@",propertyListResults);
            NSArray *items = [propertyListResults valueForKeyPath:STACK_EXCHANGE_ITEMS];
            for (NSDictionary *item in items) {
                Question *question  = [[Question alloc]init];
                question.questionId = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_ID];
                question.titleOfQuestion = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_TITLE];
                question.questionBody=[item valueForKeyPath: STACK_EXCHANGE_ITEM_QUESTION_BODY];
                [questions addObject:question];
            }
            self.questions=questions;
        }];
        
    });
}

#pragma mark - Navigation



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = nil;
    if ([segue.identifier isEqualToString:@"Display Answers"]) {
        if ([segue.destinationViewController isKindOfClass:[AnswersForQuestionRelatedTagsTVC class]]) {
            indexPath = [self.tableView indexPathForSelectedRow];
            AnswersForQuestionTagsTVC* tvc=(AnswersForQuestionRelatedTagsTVC*)segue.destinationViewController;
            tvc.questionId=self.questions[indexPath.row].questionId;
            
        }
        
    }
    
}
@end
