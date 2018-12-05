# dotfiles

personal mac setup: dotfiles, preferences, apps

## Install

```sh
mkdir -p ~/Desktop/dotfiles
cd ~/Desktop/dotfiles
curl --location https://github.com/punkusha/dotfiles/tarball/master | tar -xz --strip-components 1 --exclude={.editorconfig,.gitignore,README.md,LICENSE}
```

- `Brewfile`: A list of command-line utils, apps, and others, that will be installed via [Homebrew](https://brew.sh/), [Homebrew-Cask](https://caskroom.github.io/), and [`mas-cli`](https://github.com/mas-cli/mas)

> Don't blindly run my scripts. Use at your own risk!

## Credits

Inspired by [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles)

## License

MIT © punkusha
