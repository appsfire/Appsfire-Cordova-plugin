
#import <UIKit/UIKit.h>

typedef void(^AppsfireAdTimerCompletion)(BOOL accepted);

@interface AppsfireAdTimerView : UIView

- (id)initWithCountdownStart:(NSInteger)startNumber;

- (void)presentWithCompletion:(AppsfireAdTimerCompletion)completion;

@end
