//
//  AnswersForQuestionTagsTVC.m
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 13/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "AnswersForQuestionTagsTVC.h"

@interface AnswersForQuestionTagsTVC ()

@end

@implementation AnswersForQuestionTagsTVC

-(void)setAnswers:(NSMutableArray<Answer *> *)answers
{
    _answers = answers;
    [self.tableView reloadData];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.answers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Answer Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.answers[indexPath.row].titleForAnswer;
    NSMutableAttributedString *updateText =
    [[NSMutableAttributedString alloc] initWithData:[self.answers[indexPath.row].titleForAnswer dataUsingEncoding:NSUTF8StringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                      NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                 documentAttributes:nil
                                              error:nil];
    [cell.textLabel setAttributedText:updateText];
    
    return cell;
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
