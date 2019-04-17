# LibreSSL ebuilds testing repo

LibreSSL is already in Gentoo, but still requires [a lot of ebuilds](https://github.com/gentoo/libressl/wiki/Transition-plan#packages-not-converted-yet)
to be fixed. This overlay serves as a testing ground and makes testing easier
by providing an openssl dummy ebuild, so you can compile packages against
LibreSSL which don't have the 'libressl' USE flag yet.

## How to install the overlay

Use [`eselect-repository`](https://wiki.gentoo.org/wiki/Eselect/Repository):
```
# eselect repository enable libressl
```
Now you can use `emerge --sync` or `emaint sync -r libressl` to sync this
repository.

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
