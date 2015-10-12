//
//  QuestionTagsTVC.h
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionTagsTVC : UITableViewController

@property (strong, nonatomic)NSString *questionTag;
@property (strong, nonatomic)NSMutableArray<Question *> *questions;
@end
