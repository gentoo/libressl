# LibreSSL ebuilds testing repo

This is highly experimental and may contain dirty patches.
LibreSSL itself is generally not patched (exceptions are trivial backports from upstream revisions).

## How to install the overlay

With paludis: see [Paludis repository configuration](http://paludis.exherbo.org/configuration/repositories/index.html)

With layman:
```layman -f -o https://raw.githubusercontent.com/gentoo/libressl/master/libressl-overlay.xml -a libressl``` or ```layman -a libressl```

## links

[Gentoo bug report](https://bugs.gentoo.org/show_bug.cgi?id=508750)

[Compatibility analysis](https://devsonacid.wordpress.com/2014/07/12/how-compatible-is-libressl/)

[security related blog post](https://www.agwa.name/blog/post/libressls_prng_is_unsafe_on_linux)

[LibreSSL on Gentoo blog post](https://blog.hboeck.de/archives/851-LibreSSL-on-Gentoo.html)

[Tested ebuilds with libressl](https://github.com/gentoo/libressl/wiki)

## Repoman status
[![Repoman Status](https://travis-ci.org/gentoo/libressl.png)](https://travis-ci.org/gentoo/libressl)

## Contact
[![Gitter chat](https://badges.gitter.im/gentoo/libressl.png)](https://gitter.im/gentoo/libressl)
