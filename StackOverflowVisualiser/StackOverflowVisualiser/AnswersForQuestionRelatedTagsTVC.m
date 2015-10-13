//
//  AnswersForQuestionRelatedTagsTVC.m
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 13/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "AnswersForQuestionRelatedTagsTVC.h"
#import "StackExchange.h"
#import "StackoverflowAsyncRequestHelper.h"

@interface AnswersForQuestionRelatedTagsTVC ()

@end

@implementation AnswersForQuestionRelatedTagsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchAnswers];
}

-(void)fetchAnswers
{
#warning implement correct url
    NSURL *searchAnswerURL = [StackExchange URLForSearch:self.questionId];
    NSMutableArray<Answer *>  *answers = [[NSMutableArray alloc]init];
    StackoverflowAsyncRequestHelper *asyncRequest = [[StackoverflowAsyncRequestHelper alloc]initWithURL: searchAnswerURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [asyncRequest startRequestWithCompletionBlock:^(NSData *responseData) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                options:0
                                                                                  error:NULL];
            NSArray *items = [propertyListResults valueForKeyPath:STACK_EXCHANGE_ITEMS];
            for (NSDictionary *item in items) {
                Answer *answer  = [[Answer alloc]init];
                answer.answerId = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_ID];
                answer.titleForAnswer = [item valueForKeyPath:STACK_EXCHANGE_ITEM_QUESTION_TITLE];
                [answers addObject:answer];
            }
            self.answers=answers;
        }];
        
    });

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
