#     18-india-insert-3d-print

[Openscad](https://openscad.org/) project of 3d printed insert (aka organizer) for [18 India boardgame](https://boardgamegeek.com/boardgame/344937/18-india).

## Required software

1. [Openscad](https://openscad.org/) - for render .stl files
1. [Slic3r](https://slic3r.org/) - for splitting .stl files
1. [Oak build](https://github.com/kirillsulim/oak-build) - for build script
1. [URW Bookman font](https://fontesk.com/bookman-typeface/) - font for tile box label
1. [Black Ops One font](https://fonts.google.com/specimen/Black+Ops+One) - font for card dividers

## Build

```sh
oak build
```

.stl files will be found in `./build` directory.

## Known issues

1. Due to some errors this models are not valid manyfolds. In that case Slic3r splits models to some empty files that needs to be filtered out manually.


## Acknowledgement

1. This project uses [The-Boardgame-Insert-Toolkit](https://github.com/dppdppd/The-Boardgame-Insert-Toolkit).
2. This project uses rework of [Parametric 18xx Tile Tray](https://www.thingiverse.com/thing:4594612) by [MysteryDough](https://www.thingiverse.com/mysterydough/designs).

