# File format specification #

This is a specification for a file format designed by a bunch of people in the #osdev channel on irc.freenode.net, including Daniel Lindberg (dajoh) and Nick Markwell (duckinator).

Basic design:
    /*
     * The id of the root directory ("/"), this does NOT have an entry in the ToC.
     * Children that are in the root directory have their parentid set to this.
     */
    #define FF_ID_ROOT 0xFFFFFFFF
    
    typedef struct {
        uint8_t magic[4];
        uint32_t version;
        uint64_t offset;
    } FF_header_t;
    
    typedef struct {
        uint32_t entries;
    } FF_toc_header_t;
    
    typedef struct {
        int8_t name[256];
        uint32_t id;
        uint32_t parentid;
        uint64_t size;
        uint64_t allocated;
        uint64_t attributes;
        uint64_t offset;
    } FF_toc_entry_t;
    
