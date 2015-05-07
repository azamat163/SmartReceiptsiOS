//
//  SettingsSwitchCell.h
//  SmartReceipts
//
//  Created by Jaanus Siim on 06/05/15.
//  Copyright (c) 2015 Will Baumann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsSwitchCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setSwitchOn:(BOOL)isOn;
- (BOOL)isSwitchOn;

@end
