//
//  MenuViewController.m
//  SIBUR App
//
//  Created by whoami on 5/19/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

@implementation MenuViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.cellLabel.text = @"Финансы";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"star_white";
        cell.alternativeImageName = @"star";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    } else if (indexPath.row == 1) {
        cell.cellLabel.text = @"История";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"history_white";
        cell.alternativeImageName = @"history";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    } else if (indexPath.row == 2) {
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
        cell.cellLabel.text = @"Уведомления";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"notification_white";
        cell.alternativeImageName = @"notification";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    } else if (indexPath.row == 3) {
        cell.cellLabel.text = @"Профиль";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"profile_white";
        cell.alternativeImageName = @"profile";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    } else if (indexPath.row == 4) {
        cell.cellLabel.text = @"Написать нам";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"mail_white";
        cell.alternativeImageName = @"mail";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    } else if (indexPath.row == 5) {
        cell.cellLabel.text = @"Настройки";
        cell.cellLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
        cell.cellLabel.textColor = [UIColor whiteColor];
        cell.imageName = @"settings_white";
        cell.alternativeImageName = @"settings";
        cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.cellLabel.textColor = [UIColor colorWithRed:20.0/255.0 green:140.0/255.0 blue:148.0/255.0 alpha:1.0];
    cell.cellImageView.image = [UIImage imageNamed:cell.alternativeImageName];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"finance" sender:self];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"history" sender:self];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"notification" sender:self];
    } else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"profile" sender:self];
    } else if (indexPath.row == 4) {
        [self composeMail];
    } else if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"settings" sender:self];
    }
}

- (void)composeMail {
    NSString *emailTitle = @"Обращение в службу поддержки";
    
    NSArray *toRecipents = [NSArray arrayWithObject:@"mountainviewer@yahoo.com"];
    
    MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        mailComposeVC.mailComposeDelegate = self;
        [mailComposeVC setSubject:emailTitle];
        [mailComposeVC setToRecipients:toRecipents];
        
        [self presentViewController:mailComposeVC animated:YES completion:nil];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.cellLabel.textColor = [UIColor whiteColor];
    cell.cellImageView.image = [UIImage imageNamed:cell.imageName];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    
}

@end
