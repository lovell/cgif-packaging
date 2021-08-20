# cgif-packaging

Packaging scripts and configuration to simplify the installation of
[cgif](https://github.com/dloebl/cgif) on macOS and Ubuntu Linux.

## macOS

To install `cgif` via `brew`:

```sh
brew tap lovell/cgif-packaging https://github.com/lovell/cgif-packaging.git
brew install lovell/cgif-packaging/cgif
```

## Ubuntu

To install `cgif` via `apt`:

```sh
sudo add-apt-repository ppa:lovell/cgif
sudo apt-get update
sudo apt-get install libcgif-dev
```

Supports:

* 20.04 Focal (LTS)
* 21.04 Hirsute
