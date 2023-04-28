#import "HPDataParser.h"
//#import "data_parser.h"

@implementation HPDataParser {
    DataParser *_cDataParser;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cDataParser = create_data_parser();
    }
    return self;
}

- (void)dealloc {
    if (_cDataParser) {
        free_data_parser(_cDataParser);
        _cDataParser = NULL;
    }
}

- (void)setBufferSize:(size_t)size {
    set_buffer_size(_cDataParser, size);
}

- (void)setStartString:(NSData *)start {
    set_start_string(_cDataParser, (const char *)[start bytes]);
}

- (void)setEndString:(NSData *)end {
    set_end_string(_cDataParser, (const char *)[end bytes]);
}

- (void)appendData:(NSData *)data {
    append_data(_cDataParser, (const char *)[data bytes]);
}

- (NSData *)processData {
    char *output = process_data(_cDataParser);
    if (output) {
        NSData *result = [NSData dataWithBytes:output length:strlen(output)];
        free(output);
        return result;
    }
    return nil;
}

- (NSData *)remainingData {
    char *remaining_data = get_remaining_data(_cDataParser);
    if (remaining_data) {
        NSData *result = [NSData dataWithBytes:remaining_data length:strlen(remaining_data)];
        free(remaining_data);
        return result;
    }
    return nil;
}

@end
