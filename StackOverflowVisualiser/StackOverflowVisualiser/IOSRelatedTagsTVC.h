//
//  IOSRelatedTagsTVC.h
//  StackOverflowVisualiser
//
//  Created by Madalina Melinte on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "RelatedTagsTVC.h"
#import "Question.h"

@interface IOSRelatedTagsTVC : RelatedTagsTVC

@property (strong, nonatomic)NSMutableArray<Question *> *questions;

@end
