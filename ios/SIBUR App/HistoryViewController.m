//
//  HistoryViewController.m
//  SIBUR App
//
//  Created by whoami on 5/20/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "HistoryViewController.h"
#import "SWRevealViewController.h"
#import "HistoryTableViewCell.h"
#import <SVProgressHUD.h>

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSString *> *breaks;
@property (strong, nonatomic) NSArray<NSString *> *volume;
@property (strong, nonatomic) NSArray<NSString *> *money;
@property (strong, nonatomic) NSArray<NSString *> *months;

@end

@implementation HistoryViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.breaks.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.index.text = [NSString stringWithFormat:@"%d.", indexPath.row + 1];
    cell.first.text = self.breaks[indexPath.row];
    cell.second.text = self.volume[indexPath.row];
    cell.third.text = self.money[indexPath.row];
    cell.month.text = self.months[indexPath.row];
    
    
    return cell;
}

- (void)configureRevealVC {
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)initializeHistory {
    self.breaks = @[@"12", @"5", @"11", @"13", @"0", @"15", @"4", @"12", @"14", @"3", @"3", @"9", @"12", @"10", @"19"];
    self.volume = @[@"141", @"135", @"107", @"135", @"116", @"147", @"149", @"119", @"138", @"73", @"106", @"85", @"60", @"136", @"63"];
    self.money = @[@"960", @"853", @"609", @"661", @"524", @"675", @"965", @"621", @"568", @"901", @"582", @"613", @"648", @"666", @"551"];
    self.months = @[@"Май 2018", @"Апрель 2018", @"Март 2018", @"Февраль 2018", @"Январь 2018", @"Декабрь 2017", @"Ноябрь 2017", @"Октябрь 2017", @"Сентябрь 2017", @"Август 2017", @"Июль 2017", @"Июнь 2017", @"Май 2017", @"Апрель 2017", @"Март 2017"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    [self initializeHistory];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithDelay:0.3];
}

@end
