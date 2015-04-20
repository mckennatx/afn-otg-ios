//
//  mapSearchResultsVC.m
//  AustinFreeNet
//
//  Created by Kelsey Mayfield on 4/19/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "mapSearchResultsVC.h"

@interface mapSearchResultsVC ()
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation mapSearchResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISearchController *)searchController
{
	if (!_searchController) {
		_searchController = [[UISearchController alloc] initWithSearchResultsController:self];
		_searchController.searchResultsUpdater = self;
		_searchController.dimsBackgroundDuringPresentation = NO;
		_searchController.searchBar.delegate = self;
	}
	return _searchController;
}

- (NSMutableArray *)searchResults
{
	if (!_searchResults) {
		_searchResults = [[NSMutableArray alloc] initWithCapacity:[self.locations count]];
	}
	return _searchResults;
}

#pragma mark - Table View Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

#pragma mark - UITableViewDataSource

- (NSArray *)locations
{
	if (!_locations) {
		_locations = [MapVC AFNLocations];
	}
	return _locations;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.searchController.active) {
		return [self.searchResults count];
	} else
		return [self.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *reuseId = @"Map Cell";
	UITableViewCell *cell;
	cell = [self.tableView dequeueReusableCellWithIdentifier:reuseId];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
	}
	NSDictionary *dict;
	if (self.searchController.active) {
		dict = self.searchResults[indexPath.row];
	} else {
		dict = self.locations[indexPath.row];
	}
	
	cell.textLabel.text = dict[@"name"];
	return cell;
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
	NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"name like[c] %@", searchText];
	self.searchResults = [NSMutableArray arrayWithArray:[self.locations filteredArrayUsingPredicate:resultsPredicate]];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
	NSString *query = searchController.searchBar.text;
	[self filterContentForSearchText:query scope:nil];
	[self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
	[self updateSearchResultsForSearchController:self.searchController];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
