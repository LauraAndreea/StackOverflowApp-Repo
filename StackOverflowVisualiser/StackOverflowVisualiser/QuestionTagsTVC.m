//
//  QuestionTagsTVC.m
//  StackOverflowVisualiser
//
//  Created by Laura-Andreea Morhan on 12/10/15.
//  Copyright © 2015 Madalina Melinte. All rights reserved.
//

#import "QuestionTagsTVC.h"
#import "StackoverflowAsyncRequestHelper.h"
#import "Question.h"
#import "StackExchange.h"

@interface QuestionTagsTVC ()

@end

@implementation QuestionTagsTVC

#pragma mark - Properties

- (void)setQuestions:(NSMutableArray<Question *> *)questions
{
    _questions = questions;
    [self.tableView reloadData];
}

#pragma mark - View Controller Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Question Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.questions[indexPath.row].titleOfQuestion ;
    
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
