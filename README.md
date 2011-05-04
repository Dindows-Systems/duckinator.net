Requires `ruby`, along with the `redcarpet` and `liquid` ruby gems.

Released under MIT/X11 license (see COPYING)

If you encounter the following error on a page when trying to run this or something based on it:

```
invalid byte sequence in US-ASCII
```

Try setting the `LC_CTYPE` environment variable to `en_US.UTF-8`, on [duostack](http://duostack.com) this is accomplished with:

```bash
duostack env add LC_CTYPE=en_US.UTF-8
duostack restart
```

