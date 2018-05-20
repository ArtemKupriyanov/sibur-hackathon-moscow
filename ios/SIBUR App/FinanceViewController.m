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
    return;
}

- (void)addRangeSlider {
    self.slider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(22, 40, 300, 20)];
    self.slider.delegate = self;
    [self.sliderView addSubview:self.slider];
    self.slider.tintColor = [UIColor colorWithRed:20.0/255.0 green:140.0/255.0 blue:148.0/255.0 alpha:1.0];
    
    //self.slider.center = self.sliderView.center;
    
    self.slider.delegate = self;
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
                       [PNPieChartDataItem dataItemWithValue:20 color:PNFreshGreen description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNDeepGreen description:@"GOOG I/O"],
                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(220, 20, 100.0, 100.0) items:items];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    [self configureViews];
    [self addRangeSlider];
    [self addCircleChart];
    [self addPieChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
