// data_parser.c

#include "data_parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Create a new DataParser instance and allocate memory for it
DataParser *create_data_parser() {
  DataParser *parser = (DataParser *) malloc(sizeof(DataParser));
  parser->buffer = NULL;
  parser->buffer_size = 0;
  parser->data_length = 0;
  parser->start_string = NULL;
  parser->end_string = NULL;
  return parser;
}

// Set the buffer size for the DataParser instance
void set_buffer_size(DataParser *parser, size_t size) {
  if (parser->buffer != NULL) {
    free(parser->buffer);
  }
  parser->buffer = (char *) malloc(size * sizeof(char));
  parser->buffer_size = size;
  parser->data_length = 0;
}

// Set the start string for the DataParser instance
void set_start_string(DataParser *parser, const char *start) {
  if (parser->start_string != NULL) {
    free(parser->start_string);
  }
  parser->start_string = strdup(start);
}

// Set the end string for the DataParser instance
void set_end_string(DataParser *parser, const char *end) {
  if (parser->end_string != NULL) {
    free(parser->end_string);
  }
  parser->end_string = strdup(end);
}

// Append data to the DataParser instance's buffer
void append_data(DataParser *handler, const char *data) {
  size_t data_length = strlen(data);
  
  // Resize the buffer if needed
  while (handler->data_length + data_length + 1 > handler->buffer_size) {
    handler->buffer_size *= 2;
    handler->buffer = (char *)realloc(handler->buffer, handler->buffer_size);
    if (!handler->buffer) {
      fprintf(stderr, "Error: Failed to resize buffer.\n");
      exit(1);
    }
  }
  
  // Copy the data to the buffer
  memcpy(handler->buffer + handler->data_length, data, data_length);
  handler->data_length += data_length;
  handler->buffer[handler->data_length] = '\0';
}

// Process the data in the DataParser instance's buffer
char *process_data(DataParser *parser) {
  char *start_ptr = strstr(parser->buffer, parser->start_string);
  if (!start_ptr) {
    return NULL;
  }
  
  char *end_ptr = strstr(start_ptr + strlen(parser->start_string), parser->end_string);
  if (!end_ptr) {
    return NULL;
  }
  
  // Extract the data between the start and end strings
  size_t output_length = end_ptr - (start_ptr + strlen(parser->start_string));
  char *output = (char *)malloc(output_length + 1);
  strncpy(output, start_ptr + strlen(parser->start_string), output_length);
  output[output_length] = '\0';
  
  // Remove the processed data from the buffer, including the start_string and the end_string
  size_t removed_length = (end_ptr + strlen(parser->end_string)) - start_ptr;
  size_t remaining_length = parser->data_length - removed_length;

  memmove(start_ptr, end_ptr + strlen(parser->end_string), remaining_length);
  parser->data_length = remaining_length;
  parser->buffer[parser->data_length] = '\0';
  
  return output;
}

// Add a new function to return the remaining data in the buffer
char *get_remaining_data(DataParser *parser) {
  char *remaining_data = (char *)malloc(parser->data_length + 1);
  strncpy(remaining_data, parser->buffer, parser->data_length);
  remaining_data[parser->data_length] = '\0';
  return remaining_data;
}

// Free the memory allocated for the DataParser instance
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
