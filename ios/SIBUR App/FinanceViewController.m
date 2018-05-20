//
//  FinanceViewController.m
//  SIBUR App
//
//  Created by whoami on 5/20/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "FinanceViewController.h"
#import "SWRevealViewController.h"
#import "TTRangeSlider.h"
#import "PNChart.h"
#import <UserNotifications/UserNotifications.h>

@interface FinanceViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *economyView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIView *sliderView;

@property (weak, nonatomic) IBOutlet UILabel *money;

@property (strong, nonatomic) TTRangeSlider *slider;
@property (strong, nonatomic) PNCircleChart *circleChart;
@property (strong, nonatomic) PNPieChart *pieChart;

@property (strong, nonatomic) NSArray<NSNumber *> *moneys;

@end

@implementation FinanceViewController

- (void)configureRevealVC {
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)configureViews {
    self.economyView.layer.cornerRadius = 10.0;
    self.leftView.layer.cornerRadius = 10.0;
    self.downView.layer.cornerRadius = 10.0;
    self.rightView.layer.cornerRadius = 10.0;
    self.sliderView.layer.cornerRadius = 10.0;
}

- (void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum {
    //self.circleChart = nil;
    //self.pieChart = nil;
    NSUInteger min = selectedMinimum;
    NSUInteger max = selectedMaximum;
    
    [self updateMoneyWithMin:min andMax:max];

    //[self addRangeSlider];
    //[self addCircleChart];
}

- (void)updateMoneyWithMin:(NSUInteger)min andMax:(NSUInteger)max {
    NSUInteger total = 0;
    
    for (NSUInteger i = min; i < max; ++i) {
        total += [self.moneys[i] intValue];
    }
    
    self.money.text = [NSString stringWithFormat:@"%ld", total];
}


- (void)addRangeSlider {
    self.slider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(22, 40, 300, 20)];
    self.slider.delegate = self;
    [self.sliderView addSubview:self.slider];
    self.slider.tintColor = [UIColor colorWithRed:20.0/255.0 green:140.0/255.0 blue:148.0/255.0 alpha:1.0];
    
    //self.slider.center = self.sliderView.center;
    
    self.slider.minValue = 1;
    self.slider.maxValue = 31;
    
    NSNumberFormatter *customFormatter = [[NSNumberFormatter alloc] init];
    customFormatter.positiveSuffix = @" мая";
    self.slider.numberFormatterOverride = customFormatter;
}

- (void)addCircleChart {
    self.circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(50.0, 35.0, 60.0, 120.0)
                                                      total:@100
                                                    current:@80
                                                  clockwise:YES];
    
    self.circleChart.backgroundColor = [UIColor whiteColor];
    
    [self.circleChart setStrokeColor:[UIColor clearColor]];
    [self.circleChart setStrokeColorGradientStart:[UIColor blueColor]];
    [self.circleChart strokeChart];
    
    [self.leftView addSubview:self.circleChart];
}

- (void)addPieChart {
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNLightGreen],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(220, 10, 115.0, 115.0) items:items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendPositionRight;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
    [self.downView addSubview:legend];
    
    [self.downView addSubview:self.pieChart];
}

- (void)registerLocalNotifications {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"granted: %d; error:%@\n", granted, error);
    }];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Обслуживание завершено!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Вагон №57463309 завершил прохождение Капитального Ремонта 20.05.2018 в 09:30 в Депо-Ленинское." arguments:nil];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = 15;
    components.minute = 07;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    // Create the request object.
    UNNotificationRequest *request = [UNNotificationRequest
                                      requestWithIdentifier:@"LNRequest" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)initializeArrayData {
    self.moneys = @[@83, @76, @90, @93, @53, @79, @81, @83, @76, @90, @93, @53, @79, @81, @83, @76, @90, @93, @53, @79, @81, @83, @76, @90, @93, @53, @79, @81, @83, @76, @90];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerLocalNotifications];
    [self configureRevealVC];
    [self configureViews];
    [self addRangeSlider];
    [self addCircleChart];
    [self addPieChart];
    [self initializeArrayData];
    [self updateMoneyWithMin:(NSUInteger)self.slider.selectedMinimum andMax:(NSUInteger)self.slider.selectedMaximum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
