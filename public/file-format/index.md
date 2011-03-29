# File format specification #

This is a specification for a file format designed by a bunch of people in the #osdev channel on irc.freenode.net, including Daniel Lindberg (dajoh) and Nick Markwell (duckinator).

Basic design:
    typedef struct {
        uint8_t magic;
        uint32_t version;
        uint64_t offset;
    } FF_header_t;
    
    typedef struct {
  	  	char name[256];
  	  	uint32_t name_hash;
  	  	uint64_t length;
  	  	uint64_t offset;
    } FF_file_header_t;
    
    typedef struct {
        char name[256];
        uint32_t id;
        uint32_t parentid;
        uint64_t size;
        uint64_t allocated;
        uint64_t attributes;
        uint64_t offset;
    } FF_toc_entry_t;
    
