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
//  [self.tableView set]
  if (self.tableView.editing) {
    [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
  } else{
    [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
  }
  
  //  self.tableView.editing = YES;
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
  
  [self addToDoToArrayWithTitle:@"buy milk"
                 WithDescrition:@"Chocolate"
                   withPriority:@"1"
                     withStatus:YES];
  
  [self addToDoToArrayWithTitle:@"Visit dentist"
                 WithDescrition:@"Dr. Who"
                   withPriority:@"6"
                     withStatus:NO];
  
  [self addToDoToArrayWithTitle:@"Stand up every hour"
                 WithDescrition:@"take care of you back"
                   withPriority:@"1"
                     withStatus:NO];
}

-(void)addToDoToArrayWithTitle:(NSString *)itemTitle
                WithDescrition:(NSString *)itemDescription
                  withPriority:(NSString *)priority
                    withStatus:(bool)status{
  
  NSMutableDictionary *toDoListRow = [[NSMutableDictionary alloc] init];
  
  [toDoListRow setObject:itemTitle forKey:@"itemTitle"];
  [toDoListRow setObject:itemDescription forKey:@"itemDescription"];
  [toDoListRow setObject:priority forKey:@"priorityNumber"];
  [toDoListRow setObject:[NSNumber numberWithBool:status] forKey:@"status"];
  [self.toDoList addObject:toDoListRow];
  [self.tableView reloadData];
}

-(void)addItemWithTitle:(NSString *)itemTitle
         WithDescrition:(NSString *)itemDescription
           withPriority:(NSString *)priority
             withStatus:(bool)status{
  [self addToDoToArrayWithTitle:itemTitle
                 WithDescrition:itemDescription
                   withPriority:priority
                     withStatus:status];
  
}

//MARK: Table View delegate and data source
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.toDoList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
  } else if(editingStyle == UITableViewCellEditingStyleInsert){
    
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return [self.toDoList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *cellIdentifier = @"toDoCell";
  ToDoTableViewCell *cell = (ToDoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                                 forIndexPath:indexPath];
  if (cell) {
    //Get the actual row item using the index path
    NSMutableDictionary *toDoListRow = [[NSMutableDictionary alloc] init];
    toDoListRow = (NSMutableDictionary *)self.toDoList[indexPath.row];
    
    //Set the cell values
    cell.priorityNumber.text = toDoListRow[@"priorityNumber"];
    cell.itemTitle.text = toDoListRow[@"itemTitle"];
    cell.itemDescription.text = toDoListRow[@"itemDescription"];
    cell.status = [toDoListRow[@"status"] boolValue];
    
    cell.showsReorderControl = YES;
  }
  return cell;
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


//MARK: Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"showDetail"]) {
    NSMutableDictionary *toDoListRow = [[NSMutableDictionary alloc] init];
    DetailViewController *destinationVC = [DetailViewController alloc];
    destinationVC = (DetailViewController *) segue.destinationViewController;
    
    //Get the table row selected
    NSIndexPath *indexOfCellSelected = self.tableView.indexPathForSelectedRow;
    toDoListRow = (NSMutableDictionary *)self.toDoList[indexOfCellSelected.row];
    
    //Set the values that will be displayed in the detail view
    [destinationVC setDetailItem:toDoListRow];
  } else if ([segue.identifier isEqualToString:@"showAdd"]){
    AddViewController *destinationVC = [AddViewController alloc];
    destinationVC = (AddViewController *) segue.destinationViewController;
    //Send instance of the VC as the delegate
    destinationVC.delegate = self;
  }
  
}

@end
