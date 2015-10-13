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
                question.questionBody=[item valueForKeyPath:STACK_EXCHANGE_ITEM_BODY];
                [questions addObject:question];
            }
            self.questions=questions;
        }];
        
    });
}

@end
