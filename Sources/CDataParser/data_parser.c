// data_parser.c

#include "data_parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


DataParser *create_data_parser() {
  DataParser *parser = (DataParser *) malloc(sizeof(DataParser));
  parser->buffer = NULL;
  parser->buffer_size = 0;
  parser->data_length = 0;
  parser->start_string = NULL;
  parser->end_string = NULL;
  return parser;
}

void set_buffer_size(DataParser *parser, size_t size) {
  if (parser->buffer != NULL) {
    free(parser->buffer);
  }
  parser->buffer = (char *) malloc(size * sizeof(char));
  parser->buffer_size = size;
  parser->data_length = 0;
}

void set_start_string(DataParser *parser, const char *start) {
  if (parser->start_string != NULL) {
    free(parser->start_string);
  }
  parser->start_string = strdup(start);
}

void set_end_string(DataParser *parser, const char *end) {
  if (parser->end_string != NULL) {
    free(parser->end_string);
  }
  parser->end_string = strdup(end);
}

void append_data(DataParser *handler, const char *data) {
  size_t data_length = strlen(data);
  
  while (handler->data_length + data_length + 1 > handler->buffer_size) {
    handler->buffer_size *= 2;
    handler->buffer = (char *)realloc(handler->buffer, handler->buffer_size);
    if (!handler->buffer) {
      fprintf(stderr, "Error: Failed to resize buffer.\n");
      exit(1);
    }
  }
  
  memcpy(handler->buffer + handler->data_length, data, data_length);
  handler->data_length += data_length;
  handler->buffer[handler->data_length] = '\0';
}

char *process_data(DataParser *parser) {
  char *start_ptr = strstr(parser->buffer, parser->start_string);
  if (!start_ptr) {
    return NULL;
  }
  
  char *end_ptr = strstr(start_ptr + strlen(parser->start_string), parser->end_string);
  if (!end_ptr) {
    return NULL;
  }
  
  size_t output_length = end_ptr - (start_ptr + strlen(parser->start_string));
  char *output = (char *)malloc(output_length + 1);
  strncpy(output, start_ptr + strlen(parser->start_string), output_length);
  output[output_length] = '\0';
  
  size_t remaining_length = parser->data_length - (end_ptr + strlen(parser->end_string) - parser->buffer);
  memmove(start_ptr, end_ptr + strlen(parser->end_string), remaining_length);
  parser->data_length -= (output_length + strlen(parser->start_string) + strlen(parser->end_string));
  parser->buffer[parser->data_length] = '\0';
  
  return output;
}

void free_data_parser(DataParser *parser) {
  if (parser->buffer != NULL) {
    free(parser->buffer);
  }
  if (parser->start_string != NULL) {
    free(parser->start_string);
  }
  if (parser->end_string != NULL) {
    free(parser->end_string);
  }
  free(parser);
}
