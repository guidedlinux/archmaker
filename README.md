# ArchMaker
> Quickly and easily create your own arch-based GNU/Linux-distribution.

ArchMaker is a program that generates scripts which then can generate an iso-file of your own distribution.

You just have to select the programs you want to install, an /etc/skel-folder, enter some information and select a slideshow. It uses archiso to generate the ISO-file and [Calamares](https://www.calamares.io) as the installer.

![](https://archmaker.guidedlinux.org/screenshot.png)

## Dependencies

* **Arch Linux (64 bit)** - base-devel
* git
* VTE
* GTK 3
* gtkmm 3
* archiso

## Installation

### Building

To get the dependencies:
```sh
sudo pacman -S base-devel git vte3 gtk3 gtkmm3 archiso
```
Now you need to clone the Github-Repository:
```sh
git clone https://github.com/guidedlinux/archmaker.git && cd archmaker
```
After that you can compile ArchMaker:
```sh
make
sudo make install
```

This will install the .desktop file into /usr/share/applications/

### From the AUR

To build the package from the AUR, it is recommended to use an AUR-Helper (e.g. yaourt, pacaur). Then you can run:
```sh
yaourt -S archmaker
```
or
```sh
pacaur -S archmaker
```
## Sharing your distro

When you have generated your iso, you can upload it (anywhere) and share the link at [the gallery](https://archmaker.guidedlinux.org/gallery/).

## Release History

* Initial Commit

## Meta

Hannes Schulze – [guidedlinux.org](https://www.guidedlinux.org/) – projects@guidedlinux.org

Distributed under the GPL-3.0 license. See ``LICENSE`` for more information.

[https://github.com/guidedlinux/](https://github.com/guidedlinux/)

## Contributing

1. Fork it (<https://github.com/guidedlinux/archmaker/fork>)
1. Create your feature branch (`git checkout -b feature/fooBar`)
1. Commit your changes (`git commit -am 'Add some fooBar'`)
1. Push to the branch (`git push origin feature/fooBar`)
1. Create a new Pull Request
