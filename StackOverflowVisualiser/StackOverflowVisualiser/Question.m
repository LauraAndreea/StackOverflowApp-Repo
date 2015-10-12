//
//  Question.m
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "Question.h"

@interface Question()

@end

@implementation Question

-(void)setQuestionId:(NSString *)questionId
{
    _questionId = questionId;
}

-(void)setTitleOfQuestion:(NSString *)titleOfQuestion
{
    _titleOfQuestion = titleOfQuestion;
}

-(void)setAnswersForQuestion:(NSMutableArray<Answer *> *)answersForQuestion
{
    _answersForQuestion = answersForQuestion;
}

@end
