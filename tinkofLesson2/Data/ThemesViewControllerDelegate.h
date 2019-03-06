//
//  ThemesViewControllerDelegate.h
//  tinkofLesson2
//
//  Created by Andrey Minin on 05/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ThemesViewController;


NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>

- (void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END
