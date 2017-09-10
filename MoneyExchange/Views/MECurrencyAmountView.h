#import <UIKit/UIKit.h>

@interface MECurrencyAmountView : UIView

@property(nonatomic, weak, readonly) UILabel *currencyLabel;
@property(nonatomic, weak, readonly) UITextField *amountTextField;
@property(nonatomic, weak, readonly) UILabel *accountLabel;
@property(nonatomic, weak, readonly) UILabel *rateLabel;

@end
