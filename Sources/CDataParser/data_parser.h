// data_parser.h

#ifndef DATA_PARSER_H
#define DATA_PARSER_H

#include <stddef.h>

typedef struct {
    char *buffer;
    size_t buffer_size;
    size_t data_length;
    char *start_string;
    char *end_string;
} DataParser;

DataParser *create_data_parser();
void set_buffer_size(DataParser *parser, size_t size);
void set_start_string(DataParser *parser, const char *start);
void set_end_string(DataParser *parser, const char *end);
void append_data(DataParser *parser, const char *data);
char *process_data(DataParser *parser);
void free_data_parser(DataParser *parser);

#endif // DATA_PARSER_H
