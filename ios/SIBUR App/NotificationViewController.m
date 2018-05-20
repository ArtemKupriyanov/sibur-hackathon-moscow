//
//  NotificationViewController.m
//  SIBUR App
//
//  Created by whoami on 5/20/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "NotificationViewController.h"
#import "SWRevealViewController.h"
#import "NotificationTableViewCell.h"
#import <SVProgressHUD.h>

@interface NotificationViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<NSString *> *names;
@property (strong, nonatomic) NSArray<NSString *> *times;
@property (strong, nonatomic) NSArray<NSString *> *texts;
@property (strong, nonatomic) NSArray<NSString *> *icons;

@end

@implementation NotificationViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.names.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    NotificationTableViewCell *cell = (NotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.internalView.layer.cornerRadius = 10.0;
    cell.icon.image = [UIImage imageNamed:self.icons[indexPath.row]];
    cell.text.text = self.texts[indexPath.row];
    cell.time.text = self.times[indexPath.row];
    cell.title.text = self.names[indexPath.row];
    
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

- (void)initializeNotifications {
    self.names = @[@"Обслуживание завершено", @"Прибыл", @"Прибыл", @"Отправился в сервис", @"Проблема в пути", @"Обслуживание завершено", @"Прибыл", @"Отправился в сервис"];
    
    self.times = @[@"20 мая 2018", @"8 мая 2018", @"12 марта 2018", @"17 февраля 2018", @"24 января 2018", @"11 декабря 2017", @"23 ноября 2017", @"8 сентября 2017"];
    
    self.texts = @[@"Вагон №57463309 завершил прохождение Капитального Ремонта 20.05.2018 в 09:30 в Депо-Ленинское.",
                   @"Вагон №51810067 прибыл 08.05.2018 в 19:32 на станцию Рожок.",
                   @"Вагон №50885854 прибыл 12.03.2018 в 07:11 на станцию Ясная поляна.",
                   @"Вагон №57017048 отправился 17.02.2018 в 23:31 на прохождение Вакуумной Очистки и Гидроиспытания в Депо-Комсомольское.",
                   @"С вагоном №57459737 произошла внештатная ситуация 24.01.2018 в 12:13.",
                   @"Вагон №50809839 завершил прохождение Деповского Ремонта 11.12.2017 в 09:30 в Депо-Молодежное.",
                   @"Вагон №50535723 прибыл 23.11.2017 в 4:20 на станцию Георгополь.",
                   @"Вагон №57725048 отправился 08.09.2017 в 8:23 на прохождение Капитального Ремонта в Депо-Ленинское."];
    
    self.icons = @[@"kit", @"flag", @"flag", @"plane", @"problem", @"kit", @"flag", @"plane"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    [self initializeNotifications];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithDelay:0.3];
}

@end
