#import <UIKit/UIKit.h>
#import "MECurrencyDisplayItem.h"

@class MECurrencyCarouselViewController;

@protocol MECurrencyCarouselViewControllerDelegate <NSObject>

- (void)carouselViewController:(MECurrencyCarouselViewController *)controller
               didChangeAmount:(double)amount
                   forCurrency:(NSString *)currency;

@end

@interface MECurrencyCarouselViewController : UIViewController

@property(nonatomic, weak) id <MECurrencyCarouselViewControllerDelegate> delegate;

@property(nonatomic, readonly) NSString *currentCurrency;

- (instancetype)initWithItems:(NSArray<MECurrencyDisplayItem *> *)items;

- (void)setItem:(MECurrencyDisplayItem *)item forIndex:(int)index;

- (void)setAmount:(double)amount forCurrency:(NSString *)currency;

@end
