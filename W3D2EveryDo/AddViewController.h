//
//  AddViewController.h
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToDoListDelegate <NSObject>

-(void)addItemWithTitle:(NSString *)itemTitle
         WithDescrition:(NSString *)itemDescription
           withPriority:(NSString *)priority
             withStatus:(bool)status
               withDate:(NSDate *)date;

@end
@interface AddViewController : UIViewController

@property (weak, nonatomic) id<ToDoListDelegate> delegate;

@end
