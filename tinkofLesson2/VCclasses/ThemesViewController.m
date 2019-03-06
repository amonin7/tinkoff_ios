
//
//  ThemesViewController.m
//  tinkofLesson2
//
//  Created by Andrey Minin on 05/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

#import "ThemesViewController.h"

//@class UIViewController;

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*_theme1.backgroundColor = UIColor.blueColor;
     _theme2.backgroundColor = UIColor.blueColor;
     _theme3.backgroundColor = UIColor.blueColor;
     */
    self.model = [Themes new];
    
    _theme1.layer.borderWidth = 1;
    _theme1.layer.cornerRadius = 7;
    _theme1.backgroundColor = self.model.theme1;

    _theme2.layer.borderWidth = 1;
    _theme2.layer.cornerRadius = 7;
    _theme2.backgroundColor = self.model.theme2;

    _theme3.layer.borderWidth = 1;
    _theme3.layer.cornerRadius = 7;
    _theme3.backgroundColor = self.model.theme3;

    
    //self.view.backgroundColor = ;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)theme1Picked:(UIButton *)sender {
    self.view.backgroundColor = _model.theme1;
    [_delegate themesViewController: self didSelectTheme: _model.theme1];
}

- (IBAction)theme2Picked:(UIButton *)sender {
    self.view.backgroundColor = _model.theme2;
    [_delegate themesViewController: self didSelectTheme: _model.theme2];
}

- (IBAction)theme3Picked:(UIButton *)sender {
    self.view.backgroundColor = _model.theme3;
    [_delegate themesViewController: self didSelectTheme: _model.theme3];
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [_model release];
    [_model dealloc];
    [_delegate release];
}

@end
