//
//  TweetCell.h
//  Twitter Client
//
//  Created by Aleksey on 9/2/16.
//  Copyright © 2016 Aleksey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *authorAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end
