//
//  StackExchange.h
//  StackOverflowVisualiser
//
//  Created by Madalina Melinte on 09/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import <Foundation/Foundation.h>

// keys (paths) to values in a related tag dictionary
#define STACK_EXCHANGE_ITEMS_NAME @"items.name"

// keys (paths) to values in dictionary
#define STACK_EXCHANGE_ITEMS @"items"
#define STACK_EXCHANGE_ITEM_BODY @"body"
#define STACK_EXCHANGE_ITEM_QUESTION_ID @"question_id"
#define STACK_EXCHANGE_ITEM_QUESTION_TITLE @"title"
#define STACK_EXCHANGE_ITEM_ANSWER_ID @"answer_id"

@interface StackExchange : NSObject

+ (NSURL *)URLForRelatedTags;
+ (NSURL *)URLForSearch: (NSString *)tag;

//Gets the answers to a set of questions identified in id
+ (NSURL *) URLforAnswersWhereQuestionIdIs:(NSString *)questionId;
@end
