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

@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HistoryViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

@end
