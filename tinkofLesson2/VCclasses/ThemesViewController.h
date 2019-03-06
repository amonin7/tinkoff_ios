//
//  ThemesViewController.h
//  tinkofLesson2
//
//  Created by Andrey Minin on 05/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController

@property (retain) id<ThemesViewControllerDelegate> delegate;

@property (retain) Themes* model;

@property (weak, nonatomic) IBOutlet UIButton *theme1;

@property (weak, nonatomic) IBOutlet UIButton *theme2;

@property (weak, nonatomic) IBOutlet UIButton *theme3;

@property (retain) UIColor* colorToSetAsDefault;

@end

NS_ASSUME_NONNULL_END
