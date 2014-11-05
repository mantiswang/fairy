//
//  ChatTableViewCell.h
//  fairy
//
//  Created by apple on 14/11/4.
//  Copyright (c) 2014年 onecat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;


@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
