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

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;
@end

@implementation mapSearchResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.searchController.searchBar sizeToFit];
	
	// know where the UISearchController will be displayed
	self.definesPresentationContext = YES;
}

- (UISearchController *)searchController
{
	if (!_searchController) {
		_searchController = [[UISearchController alloc] init];
		_searchController.searchResultsUpdater = self;
		_searchController.dimsBackgroundDuringPresentation = NO;
		_searchController.delegate = self;
		_searchController.searchBar.delegate = self;
	}
	return _searchController;
}

- (NSMutableArray *)searchResults
{
	if (!_searchResults) {
		_searchResults = [self.locations mutableCopy];
	}
	return _searchResults;
}

#pragma mark - UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.searchResults count];
}

#pragma mark - UITableViewDataSource

- (NSArray *)locations
{
	if (!_locations) {
		_locations = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AFN Locations" ofType:@"plist"]];
	}
	return _locations;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *reuseId = @"Map Cell";
	UITableViewCell *cell;
	cell = [self.tableView dequeueReusableCellWithIdentifier:reuseId];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
	}
	NSDictionary *dict = self.searchResults[indexPath.row];
	
	cell.textLabel.text = dict[@"name"];
	return cell;
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
	NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS[cd] %@) OR (address CONTAINS[cd] %@)", searchText, searchText];
	
	self.searchResults = [[self.locations filteredArrayUsingPredicate:resultsPredicate] mutableCopy];
	[self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
	NSString *query = searchController.searchBar.text;
	NSString *strippedQuery = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	[self filterContentForSearchText:strippedQuery scope:nil];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Start Search" object:self];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[self filterContentForSearchText:searchText scope:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Finish Search" object:self];
}

@end
