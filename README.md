dotfiles
==============================

Getting Started
-----------------------------

```sh
make
make install
```

Notes
-----------------------------

### Save cask apps list

It ignores apps are listed in `/etc/caskignore`.
```sh
make -B /etc/casklist
```

### Save apple store apps list

It ignores apps are listed in `/etc/masignore`.
```sh
make -B /etc/maslist
```
