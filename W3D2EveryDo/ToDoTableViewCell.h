//
//  toDoItemTableViewCell.h
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *itemTitle;
@property (strong, nonatomic) IBOutlet UILabel *itemDescription;


@property (strong, nonatomic) IBOutlet UILabel *priorityNumber;
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;

@property (nonatomic,assign) bool status;

@end
