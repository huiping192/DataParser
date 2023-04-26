#import <Foundation/Foundation.h>
#import "data_parser.h"

@interface HPDataParser : NSObject

- (instancetype)init;
- (void)setBufferSize:(size_t)size;
- (void)setStartString:(NSString *)start;
- (void)setEndString:(NSString *)end;
- (void)appendData:(NSString *)data;
- (NSString *)processData;
- (NSString *)remainingData;
- (void)dealloc;

@end
