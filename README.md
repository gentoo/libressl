# LibreSSL ebuilds testing repo

LibreSSL requires [a lot of ebuilds](https://github.com/gentoo/libressl/wiki/Transition-plan#packages-not-converted-yet)
to be fixed. This overlay serves as a testing ground and makes testing easier
by providing an openssl dummy ebuild, so you can compile packages against
LibreSSL.

The `libressl` USE flag is no longer used on main portage tree.
The dummy `dev-libs/openssl` package on this overlay only depends
on `dev-libs/libressl` to fix dependency.
This overlay goal is to provide ebuilds that require patches for build
to succeed where dummy package dependency isn’t enough.

## How to install the overlay

Use [`eselect-repository`](https://wiki.gentoo.org/wiki/Eselect/Repository):
```
# eselect repository enable libressl
```
Now you can use `emerge --sync` or `emaint sync -r libressl` to sync this
repository.

The `dev-libs/libressl` package in this overlay causes file collisions with the
`dev-libs/openssl::gentoo` package. When switching to this overlay first fetch
the LibreSSL package and then remove the OpenSSL package before installing
`dev-libs/libressl` and the `dev-libs/openssl::libressl` fake package:
```
# emerge -f dev-libs/libressl
# emerge -C dev-libs/openssl
# emerge -av1 dev-libs/libressl
# emerge @preserved-rebuild
```

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

[IRC on Libera.Chat #gentoo-libressl](irc://irc.libera.chat/gentoo-libressl)
