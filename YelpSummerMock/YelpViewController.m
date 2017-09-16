//
//  ViewController.m
//  YelpSummerMock
//
//  Created by wengyuankai on 8/26/17.
//  Copyright © 2017 wengyuankai. All rights reserved.
//

#import "YelpViewController.h"
#import "YelpDataModel.h"
#import "YelpNetworking.h"
#import "YelpTableViewCell.h"
#import "YelpDetailViewController.h"
#import "FilterViewController.h"

@interface YelpViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic) UITableView *tableView;
@property (nonatomic, copy) NSArray <YelpDataModel *> *dataModels;
@property (nonatomic) UISearchBar* searchBar;

@end


@implementation YelpViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    CLLocation *loc
    = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:@"restaurant" completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"YelpTableViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSettings)];
    
    //     Setup search bar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = self.searchBar;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];

}

- (void)didTapSettings
{
    FilterViewController *filterVC = [[FilterViewController alloc] init];
    [self.navigationController pushViewController:filterVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpDetailViewController *detailVC = [[YelpDetailViewController alloc] initWithDataModel:self.dataModels[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"YelpTableViewCell"];
    
    [cell updateBasedOnDataModel:self.dataModels[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModels count];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    
    // the following code the key that we can finally make our table be able to search based on user’s input
    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:searchBar.text completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

// Reset search bar state after cancel button clicked
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - Location manager methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    [[YelpDataStore sharedInstance] setUserLocation:currentLocation];
    
    [manager stopUpdatingLocation];
    NSLog(@"current location %lf %lf", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:currentLocation term:@"restaurant" completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

@end
