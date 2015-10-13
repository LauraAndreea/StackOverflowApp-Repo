//
//  Question.h
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Question : NSObject

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *titleOfQuestion;
@property (nonatomic, strong) NSString *questionBody;
@property (nonatomic, strong) NSMutableArray<Answer *> *answersForQuestion;

@end
