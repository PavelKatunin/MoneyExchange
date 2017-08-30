//
//  MECurrencyCarouselViewController.h
//  MoneyExchange
//
//  Created by Pavel Katunin on 8/30/17.
//  Copyright © 2017 Pavel Katunin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MECurrencyCarouselViewController;

@protocol MECurrencyCarouselViewControllerDelegate <NSObject>

- (void)carouselViewController:(MECurrencyCarouselViewController *)controller
               didChangeAmount:(double)amount
                   forCurrency:(NSString *)currency;

@end

@interface MECurrencyCarouselItem : NSObject

@property(nonatomic, copy) NSAttributedString *currency;
@property(nonatomic, copy) NSAttributedString *amount;
@property(nonatomic, copy) NSAttributedString *account;
@property(nonatomic, copy) NSAttributedString *rate;

@end

@interface MECurrencyCarouselViewController : UIViewController

@property(nonatomic, weak) id <MECurrencyCarouselViewControllerDelegate> delegate;

- (instancetype)initWithItems:(NSArray<MECurrencyCarouselItem *> *)items;

- (void)setItem:(MECurrencyCarouselItem *)item forIndex:(int)index;

@end
