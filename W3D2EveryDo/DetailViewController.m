//
//  DetailViewController.m
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *itemTitle;
@property (strong, nonatomic) IBOutlet UILabel *itemDescription;
@property (strong, nonatomic) IBOutlet UILabel *priorityNumber;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,assign) bool status;
@property (strong, nonatomic) IBOutlet UILabel *deadline;

@end

@implementation DetailViewController

- (void)setDetailItem:(id)newDetailItem {
  if (_detailItem != newDetailItem) {
    _detailItem = (NSMutableDictionary *)newDetailItem;
    _priorityNumber = [[UILabel alloc] init];
    _itemTitle = [[UILabel alloc] init];
    _itemDescription = [[UILabel alloc] init];
    _status = NO;
    
    // Update the view.
    [self configureView];
  }
}
- (void)configureView {
  // Update the user interface for the detail item.
  if (self.detailItem) {
    
    self.priorityNumber.text = self.detailItem[@"priorityNumber"];
    self.itemTitle.text = self.detailItem[@"itemTitle"];
    self.itemDescription.text = self.detailItem[@"itemDescription"];
    self.status = self.detailItem[@"status"];
    self.deadline =self.detailItem[@"deadline"];
    
  }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
