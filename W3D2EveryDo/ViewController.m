//
//  ViewController.m
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "ToDoTableViewCell.h"
#import "DetailViewController.h"
#import "AddViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *toDoList;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self configureTableView];
  [self addUIElements];
  [self setDelegate];
  [self buildData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//MARK: Preparation
-(void)configureTableView{
  UISwipeGestureRecognizer *swipToComplete = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(swipeToComplete:)]
  ;
  swipToComplete.direction = UISwipeGestureRecognizerDirectionRight;
  [self.tableView addGestureRecognizer:swipToComplete];
}

-(void)addUIElements{
  //self.tableView.ed
  self.navigationItem.leftBarButtonItem  = self.editButtonItem;
  self.editButtonItem.target = self;
  self.editButtonItem.action = @selector(editTapped);
  
  UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(showAddView:)];
  self.navigationItem.rightBarButtonItem = addButtonItem;
}
-(void)editTapped{
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  //Toggle Edit/Done button
  if (self.tableView.editing) {
    [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
  } else{
    [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
  }
}
-(void)showAddView:(id)sender {
  [self performSegueWithIdentifier:@"showAdd" sender:self];
}
-(void)setDelegate{
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}
-(void)buildData{
  self.toDoList = [[NSMutableArray alloc] init];
  NSMutableArray *tmp = [[NSMutableArray alloc] init];
  [self.toDoList addObject:tmp];
  NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
  [self.toDoList addObject:tmp2];
  
  //Add objects
  [self addItemWithTitle:@"buy milk"
          WithDescrition:@"Chocolate"
            withPriority:@"1"
              withStatus:NO
                withDate:[NSDate date]];
  
  [self addItemWithTitle:@"Visit dentist"
          WithDescrition:@"Dr. Who"
            withPriority:@"6"
              withStatus:NO
                withDate:[NSDate date]];
  
  [self addItemWithTitle:@"Stand up every hour"
          WithDescrition:@"take care of you back"
            withPriority:@"1"
              withStatus:NO
                withDate:[NSDate date]];
}

//MARK: Table View delegate and data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return self.toDoList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [self.toDoList[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *cellIdentifier = @"toDoCell";
  ToDoTableViewCell *cell = (ToDoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                                 forIndexPath:indexPath];
  if (cell) {
    //Get the actual row item using the index path
    NSMutableArray *toDoListGroup = (NSMutableArray *)self.toDoList[indexPath.section];
    NSMutableDictionary *toDoListRow = (NSMutableDictionary *)toDoListGroup[indexPath.row];
    
    //Set the cell values
    cell.priorityNumber.text = toDoListRow[@"priorityNumber"];
    cell.itemTitle.text = toDoListRow[@"itemTitle"];
    cell.itemDescription.text = toDoListRow[@"itemDescription"];
    cell.status = [toDoListRow[@"status"] boolValue];
    NSDate *deadline = (NSDate *)toDoListRow[@"deadline"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    cell.deadline.text = [dateFormatter stringFromDate:deadline];
  }
  return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.toDoList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
  } else if(editingStyle == UITableViewCellEditingStyleInsert){
    //do nothing
  }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}
-(void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
     toIndexPath:(NSIndexPath *)destinationIndexPath{
  NSMutableDictionary *item = (NSMutableDictionary *)self.toDoList[sourceIndexPath.row];
  [self.toDoList removeObjectAtIndex:sourceIndexPath.row];
  [self.toDoList insertObject:item atIndex:destinationIndexPath.row];
}
//MARK: Data Array methods
-(void)addItemWithTitle:(NSString *)itemTitle
         WithDescrition:(NSString *)itemDescription
           withPriority:(NSString *)priority
             withStatus:(bool)status
               withDate:(NSDate *)date{
  NSMutableDictionary *toDoListRow = [[NSMutableDictionary alloc] init];
  
  //Get current count of not completed todos
  NSInteger currentToDoCount = [self.toDoList[0] count];
  NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:currentToDoCount inSection:0];
  
  //Add row to to do array
  [toDoListRow setObject:itemTitle forKey:@"itemTitle"];
  [toDoListRow setObject:itemDescription forKey:@"itemDescription"];
  [toDoListRow setObject:priority forKey:@"priorityNumber"];
  [toDoListRow setObject:[NSNumber numberWithBool:status] forKey:@"status"];
  [toDoListRow setObject:date forKey:@"deadline"];
  
  //If the array is initial, initialize first
  NSMutableArray *notCompletedArray = self.toDoList[0];//[NSMutableArray alloc];
  notCompletedArray = self.toDoList[0];
  [notCompletedArray addObject:toDoListRow];
  
  //Update tablew view
  [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)completeItem:(NSIndexPath *)indexpath{
  NSMutableArray *notCompleted = self.toDoList[indexpath.section];
  NSMutableDictionary *toDoItem = (NSMutableDictionary *)notCompleted[indexpath.row];
  toDoItem[@"status"] = [NSNumber numberWithInt:YES];
  
  
  //If the array is initial, initialize first
  NSMutableArray *completedArray = self.toDoList[1];
  [completedArray addObject:toDoItem];
  
  [notCompleted removeObject:toDoItem];
  [self.tableView reloadData];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  switch (section) {
    case 0:
      return @"Not completed";
      break;
    case 1:
      return @"Completed";
      break;
    default:
      return @"";
      break;
  }
}

//MARK: Gestures
-(void)swipeToComplete:(UISwipeGestureRecognizer *)recognizer{
  NSLog(@"swipe registered");
  
  CGPoint location = [recognizer locationInView:self.tableView];
  NSIndexPath *indexSwiped = [self.tableView indexPathForRowAtPoint:location];
  [self completeItem:indexSwiped];
  
  NSLog(@"%@",indexSwiped);
}


//MARK: Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"showDetail"]) {
    DetailViewController *destinationVC = (DetailViewController *) segue.destinationViewController;
    
    //Get the table row selected
    NSIndexPath *indexOfCellSelected = self.tableView.indexPathForSelectedRow;
    NSMutableDictionary *toDoListRow = (NSMutableDictionary *)self.toDoList[indexOfCellSelected.section][indexOfCellSelected.row];
    
    //Set the values that will be displayed in the detail view
    [destinationVC setDetailItem:toDoListRow];
  } else if ([segue.identifier isEqualToString:@"showAdd"]){
    AddViewController *destinationVC = (AddViewController *) segue.destinationViewController;
    //Send instance of the VC as the delegate
    destinationVC.delegate = self;
  }
  
}

@end
