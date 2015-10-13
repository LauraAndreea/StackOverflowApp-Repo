//
//  AnswersForQuestionTagsTVC.h
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 13/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answer.h"

@interface AnswersForQuestionTagsTVC : UITableViewController

@property(nonatomic, strong)NSString *questionId;
@property(nonatomic, strong)NSMutableArray <Answer *> *answers;

@end
