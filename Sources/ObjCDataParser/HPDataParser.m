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

- (void)setStartString:(NSString *)start {
    set_start_string(_cDataParser, [start UTF8String]);
}

- (void)setEndString:(NSString *)end {
    set_end_string(_cDataParser, [end UTF8String]);
}

- (void)appendData:(NSString *)data {
    append_data(_cDataParser, [data UTF8String]);
}

- (NSString *)processData {
    char *output = process_data(_cDataParser);
    if (output) {
        NSString *result = [NSString stringWithUTF8String:output];
        free(output);
        return result;
    }
    return nil;
}

@end
