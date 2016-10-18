//
//  ViewController.m
//  Track
//
//  Created by zhe wu on 4/30/16.
//  Copyright © 2016 zhe wu. All rights reserved.
//

#import "TrackingTableViewController.h"
#import "MapViewController.h"
#import "settingViewController.h"
#import "AddTrackingViewController.h"
#import "TrackingModel.h"
#import "TrackingTableViewCell.h"

@interface TrackingTableViewController () <UITableViewDataSource, UITableViewDelegate>

/** array of tracking information */
@property (nonatomic, strong) NSArray *tracksArray;

@end

@implementation TrackingTableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //register reused cell
    [self.tableView registerClass:[TrackingTableViewCell class] forCellReuseIdentifier:@"cell"];
   
}

/**
 * Pushing in AddTrackingView Controller after type add button
 *
 *  @param sender rightBarButtonItem
 */
- (IBAction)addTrackingNumber:(UIBarButtonItem *)sender {
    AddTrackingViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTrackingViewController"];
    [self.navigationController pushViewController:addVC animated:YES];
}

/**
 *  Pushing in SettingView Controller after type setting button
 *
 *  @param sender leftBarButtonItem
 */
- (IBAction)setting:(UIBarButtonItem *)sender {
    settingViewController *settingView = [self.storyboard instantiateViewControllerWithIdentifier:@"sc"];
    //    settingView.view.frame = self.view.bounds;
    //    settingView.view.backgroundColor = [UIColor redColor];
    [self.navigationController presentViewController:settingView animated:YES completion:nil];
    //
    //    CATransition *animation = [CATransition animation];
    ////    [animation setDuration:2];
    //    [animation setType:kCATransitionPush];
    //    [animation setSubtype:kCATransitionFromTop];
    //    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //
    //    [self.navigationController pushViewController:settingView animated:YES];
    //    [[settingView.view layer] addAnimation:animation forKey:@"SwitchToView1"];
}


-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSMutableDictionary *)readingPlist{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"PackageList.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"PackageList" ofType:@"plist"];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //NSLog(@"dict = %@",dict);
    return dict;
}

#pragma mark UITableViewDataSource 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *dic= [self readingPlist];
    NSArray *array = [dic allKeys];
//    if ([array count] == 0) {
//        tableView.hidden = YES;
//    }else
//    {
//        tableView.hidden = NO;
//    }
    return [array count];
//    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic= [self readingPlist];
    
//    TrackingTableViewCell *cell = [[TrackingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    TrackingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.track = self.tracksArray[indexPath.row];
    
//    NSArray *array = [dic allKeys];
//    
//    UIView *myView = [[UIView alloc] init];
//    
//    cell.textLabel.textColor = [UIColor whiteColor];
//    cell.detailTextLabel.textColor = [UIColor whiteColor];
//    
//    NSString *checkCarrier = [array[indexPath.row] substringWithRange:NSMakeRange(0,1)];
//    
//    if ([checkCarrier isEqualToString:@"1"]) {
//        myView.backgroundColor = [UIColor brownColor];
//    }
//    if ([checkCarrier isEqualToString:@"6"]) {
//        myView.backgroundColor = [UIColor purpleColor];
//    }
//    if ([checkCarrier isEqualToString:@"9"]) {
//        myView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.93 alpha:1.0];
//        cell.textLabel.textColor = [UIColor blueColor];
//        cell.detailTextLabel.textColor = [UIColor blueColor];
//    }
//    cell.backgroundView = myView;
//    
//
//    cell.textLabel.text = array[indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.detailTextLabel.text = [[dic objectForKey: array[indexPath.row]] objectForKey:@"status_details"];
//    //[[dict objectForKey: self.trackingLabel.text]
//    NSString *check = [cell.detailTextLabel.text lowercaseString];
//    if ([check rangeOfString:@"delivered"].location != NSNotFound) {
//        cell.imageView.image = [UIImage imageNamed:@"checkMark.png"];
//    }
//    
//    cell.textLabel.font = [UIFont systemFontOfSize: 20];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dic= [self readingPlist];
    NSArray *array = [dic allKeys];

    NSLog(@"array[indexPath.row]=%@", array[indexPath.row]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     MapViewController *mapView = [storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    mapView.tracking = array[indexPath.row];
    [mapView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController: mapView animated:YES completion:nil];

}

#pragma mark UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSMutableDictionary *dict = [self readingPlist];
        NSArray *array = [dict allKeys];
        [dict removeObjectForKey: array[indexPath.row]];
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //NSLog(@"%@", path);
        NSString *doc = [path objectAtIndex:0];
        NSString *paths = [doc stringByAppendingPathComponent:@"PackageList.plist"];
        [dict writeToFile:paths atomically:YES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadData];
    }
}


@end
