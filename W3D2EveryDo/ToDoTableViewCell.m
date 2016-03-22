//
//  toDoItemTableViewCell.m
//  W3D2EveryDo
//
//  Created by Karlo Pagtakhan on 03/22/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ToDoTableViewCell.h"

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPriorityNumber:(UILabel *)priorityNumber{
  _priorityNumber = priorityNumber;
  if (priorityNumber.text){
    
  }
}
-(void)setStatus:(bool)status{
  if (status) {
    [_statusImage setImage:[UIImage imageNamed:@"checkImage"]];
    //Strike itemTitle and itemDescription
    [self strikeText:self.itemTitle];
    [self strikeText:self.itemDescription];
  } else{
    [_statusImage setImage:[[UIImage alloc] init]];
  }
}
-(void)strikeText:(UILabel *)label{
  NSMutableAttributedString *strikedString = [[NSMutableAttributedString alloc] initWithString:label.text];
  [strikedString addAttribute:NSStrikethroughStyleAttributeName
                        value:@2
                        range:NSMakeRange(0, [strikedString length])];
  label.attributedText = strikedString;
}

@end
