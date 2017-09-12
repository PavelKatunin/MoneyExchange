#import <UIKit/UIKit.h>
#import "MECurrencyDisplayItem.h"

@class MECurrencyAmountView;

@protocol MECurrencyAmountViewDelegate <NSObject>

- (void)currencyAmountView:(MECurrencyAmountView *)view
      didChangeAmountValue:(double)amount;

@end

@interface MECurrencyAmountView : UIView

@property(nonatomic, weak) id <MECurrencyAmountViewDelegate> delegate;

@property(nonatomic, weak, readonly) UILabel *currencyLabel;
@property(nonatomic, weak, readonly) UITextField *amountTextField;
@property(nonatomic, weak, readonly) UILabel *accountLabel;
@property(nonatomic, weak, readonly) UILabel *rateLabel;

@property(nonatomic, strong) MECurrencyDisplayItem *displayItem;

@end
