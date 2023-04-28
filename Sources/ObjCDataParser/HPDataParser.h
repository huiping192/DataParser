#import <Foundation/Foundation.h>
#import "data_parser.h"

@interface HPDataParser : NSObject

- (instancetype)init;

- (void)setBufferSize:(size_t)size;
- (void)setStartString:(NSData *)start;
- (void)setEndString:(NSData *)end;

- (void)appendData:(NSData *)data;

- (NSData *)processData;
- (NSData *)remainingData;

@end
