//
//  SettingsViewController.m
//  SIBUR App
//
//  Created by whoami on 5/20/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *colleagues;
@property (weak, nonatomic) IBOutlet UIButton *instruction;

@end

@implementation SettingsViewController

- (void)configureRevealVC {
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)configureButtons {
    self.colleagues.layer.borderColor = [UIColor whiteColor].CGColor;
    self.instruction.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.colleagues.layer.borderWidth = 1.0;
    self.instruction.layer.borderWidth = 1.0;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    [self configureButtons];
}


@end
