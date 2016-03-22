//
//  AddViewController.m
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "AddViewController.h"
#import "ViewController.h"

@interface AddViewController () <ToDoListDelegate>
@property (strong, nonatomic) IBOutlet UITextField *priority;
@property (strong, nonatomic) IBOutlet UITextField *itemTitle;
@property (strong, nonatomic) IBOutlet UITextField *itemdescription;

@end

@implementation AddViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  NSLog(@"Add View controller displayed");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
//MARK: IBOutlets
- (IBAction)saveItem:(id)sender {
  
  //Add the item
  [self addItemWithTitle:self.itemTitle.text
          WithDescrition:self.itemdescription.text
            withPriority:self.priority.text
              withStatus:NO];
  
  //Dismiss the view controller
  [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK: Delegate
-(void)addItemWithTitle:(NSString *)itemTitle
         WithDescrition:(NSString *)itemDescription
           withPriority:(NSString *)priority
             withStatus:(bool)status;{
  [self.delegate addItemWithTitle:itemTitle
                   WithDescrition:itemDescription
                     withPriority:priority
                       withStatus:status];
}

@end