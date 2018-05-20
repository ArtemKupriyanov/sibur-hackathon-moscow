//
//  ProfileViewController.m
//  SIBUR App
//
//  Created by whoami on 5/20/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import <FSCalendar.h>

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) FSCalendar *calendar;

@end

@implementation ProfileViewController

- (void)configureRevealVC {
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)configurePhoto {
    self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImage.layer.borderWidth = 1.5;
}

- (void)addCalendar {
    self.calendar = [[FSCalendar alloc] initWithFrame:self.bottomView.bounds];
    self.calendar.dataSource = self;
    self.calendar.delegate = self;
    [self.bottomView addSubview:self.calendar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    [self configurePhoto];
    [self addCalendar];
}

@end
