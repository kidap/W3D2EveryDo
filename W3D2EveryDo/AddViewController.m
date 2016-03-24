//
//  AddViewController.m
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "AddViewController.h"
#import "ViewController.h"

@interface AddViewController () <ToDoListDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *priority;
@property (strong, nonatomic) IBOutlet UITextField *itemTitle;
@property (strong, nonatomic) IBOutlet UITextField *itemdescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AddViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  NSLog(@"Add View controller displayed");
  self.itemTitle.delegate = self;
  self.itemdescription.delegate  = self;
  self.priority.delegate = self;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardShow:)
                                               name:UIKeyboardDidShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardHide:)
                                               name:UIKeyboardDidHideNotification object:nil];
  
//  UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                            action:@selector(hideKeyboard)];
//  [self.scrollView addGestureRecognizer:tapView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//MARK: Handle keyboard
-(void)keyboardShow:(NSNotification *)notification{
  NSValue *value = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
  CGFloat keyboardHeight = CGRectGetHeight([value CGRectValue]);
  
  CGPoint offset = CGPointMake(0, keyboardHeight/2);
  NSLog(@"%f",keyboardHeight);
  [self.scrollView setContentOffset:offset animated:YES];
}

-(void)keyboardHide:(NSNotification *)notification{
  NSValue *value = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
  CGFloat keyboardHeight = CGRectGetHeight([value CGRectValue]);
  
  CGPoint offset = CGPointMake(0, 0);
  NSLog(@"%f",keyboardHeight);
  [self.scrollView setContentOffset:offset animated:YES];
}

-(void)hideKeyboard{
  [self.priority resignFirstResponder];
  [self.itemTitle resignFirstResponder];
  [self.itemdescription resignFirstResponder];
  NSLog(@"tapOutside");
}
//MARK: IBOutlets
- (IBAction)saveItem:(id)sender {
  
  NSLog(@"Done button pressed");
  //Add the item
//  [self addItemWithTitle:self.itemTitle.text
//          WithDescrition:self.itemdescription.text
//            withPriority:self.priority.text
//              withStatus:NO
//                withDate: self.datePicker.date];
  
  //Let delegate handle the message
  [self.delegate addItemWithTitle:self.itemTitle.text
                   WithDescrition:self.itemdescription.text
                     withPriority:self.priority.text
                       withStatus:NO
                         withDate:self.datePicker.date];
  
  //Dismiss the view controller
  [self dismissViewControllerAnimated:YES completion:nil];
  
  //[self.navigationController  popViewControllerAnimated:YES];
}

//MARK: Delegate
//-(void)addItemWithTitle:(NSString *)itemTitle
//         WithDescrition:(NSString *)itemDescription
//           withPriority:(NSString *)priority
//             withStatus:(bool)status
//               withDate:(NSDate *)date;{
//  [self.delegate addItemWithTitle:itemTitle
//                   WithDescrition:itemDescription
//                     withPriority:priority
//                       withStatus:status
//                         withDate:date];
//}
//MARK: TextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}

@end
