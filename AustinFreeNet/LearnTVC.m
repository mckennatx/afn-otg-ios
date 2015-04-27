//
//  LearnTVC.m
//  AustinFreeNet
//
//  Created by Lauren McKenna on 4/13/15.
//  Copyright (c) 2015 AFN. All rights reserved.
//

#import "LearnTVC.h"

@interface LearnTVC()
//@property (weak, nonatomic) IBOutlet UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *modules;
@end

@implementation LearnTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
	
	[super viewDidLoad];
	
	// navigation controller
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
	self.navigationItem.leftBarButtonItem = backButton;
	
	UIBarButtonItem *AFNButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_logo"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickAFNButton)];
	[self.navigationItem setRightBarButtonItem:AFNButton];
}

- (IBAction)didRefresh:(UIRefreshControl *)sender {
    [self getModulesWithURL:[NSURL URLWithString:@"http://austinfreenet.pythonanywhere.com"]];
}

#pragma mark - LearnTVC delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modules count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Module Cell";
    UITableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = self.modules[indexPath.row];
	//NSLog(@"%@", dict);
    cell.textLabel.text = [dict objectForKey:@"name"];
	cell.textLabel.textColor = UIColorFromRGB(0x3E96C7);
    
    return cell;
}

#pragma mark - LearnTVC dataSource

- (NSArray *)modules
{
    if (!_modules) {
//        NSLog(@"getting modules");
        [self getModulesWithURL:[NSURL URLWithString:@"http://austinfreenet.pythonanywhere.com"]];
    }
    return _modules;
}

- (void)getModulesWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //NSLog(@"%@", response);
//        NSLog(@"%@", request.URL);
		
        if (!error) {
//            NSLog(@"no error");
            if ([request.URL isEqual:url]) {
                //NSLog(@"pulling json from url");
//                NSLog(@"data: %@", data);
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                dispatch_async(dispatch_get_main_queue(),^{
                    self.modules = arr;
					[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                });
//                NSLog(@"%@", self.modules);
            }
        }
    }];
    [task resume];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.destinationViewController isKindOfClass:[ModuleVC class]]) {
		ModuleVC *mvc = (ModuleVC *)segue.destinationViewController;
		NSIndexPath *path = [self.tableView indexPathForCell:sender];
		NSDictionary *dict = self.modules[path.row];
		mvc.moduleInfo = dict;
	} else if ([segue.identifier isEqualToString:AFN_PAGE_SEGUE]){
		BrowserViewController *browserVC = (BrowserViewController *)segue.destinationViewController;
		browserVC.url = AFN_URL;
	}
}

- (void)didClickAFNButton
{
	[self performSegueWithIdentifier:AFN_PAGE_SEGUE sender:self];
}

- (void)goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
