//
//  MenuViewController.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MenuViewControllerControllerDelegate<NSObject>

-(void)mainMenuButtonTapped;
-(void)profileButtonTapped;

-(void)mapButtonTapped;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id <MenuViewControllerControllerDelegate> delegate;

@end
