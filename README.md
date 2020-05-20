<!-- markdownlint-disable MD010 -->
<!-- markdownlint-disable MD014 -->
<!-- markdownlint-disable MD037 -->
<!-- markdownlint-disable MD040 -->
<!-- markdownlint-disable MD046 -->

# Scoop-Spotify

A [Scoop](https://github.com/lukesampson/scoop) bucket for Spotify, Spicetify and related packages.

	$ scoop bucket add spotify https://github.com/TheRandomLabs/Scoop-Spotify.git

...I've spent an unhealthy amount of time on automating all of this.

## Installing and customizing Spotify

First, the latest version of Spotify should be installed:

    $ scoop install spotify-latest

Note that Spotify should not be installed globally, as it stores files in user-specific directories.

Once Spotify is installed, [spicetify-cli](https://github.com/khanhas/spicetify-cli) can be
installed to customize the Spotify client:

    $ scoop install spicetify-cli

Again, spicetify-cli should be installed locally, as it also stores files in a user-specific
location.

[spicetify-themes](https://github.com/morpheusthewhite/spicetify-themes) can be installed for
a collection of community-created themes for Spicetify. Obviously, this should also be installed
locally:

	$ scoop install spicetify-themes

[google-spicetify](https://github.com/khanhas/google-spicetify) is also available:

	$ scoop install google-spicetify

I can recommend the
[Adapta-Nokto](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Adapta-Nokto)
theme, which can be applied by running the following:

	$ spicetify config current_theme Adapta-Nokto
	$ spicetify-apply

As an example, I will also demonstrate the installation of the
[Elementary](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Elementary) theme,
which requires Open Sans and Raleway to be installed:

	$ scoop bucket add nerd-fonts
	$ sudo scoop install Open-Sans Raleway
	$ spicetify config current_theme Elementary
	$ spicetify-apply

To install spicetify-cli and apply a theme silently, the theme can be configured before installing
spicetify-themes. When any of the Spicetify packages are installed, the current configuration
is applied, and if Spotify was open previously, it is reopened.

	$ scoop install spicetify-cli
	$ spicetify config current_theme Elementary
	$ scoop install spicetify-themes

[genius-spicetify](https://github.com/khanhas/genius-spicetify) can be installed to fetch lyrics
from Genius or Musixmatch:

	$ scoop install genius-spicetify

[spicetify-autoVolume](https://github.com/amanharwara/spicetify-autoVolume#changing-the-intervalminimum-volume)
can be installed to automatically decrease the volume at specific intervals of time:

	$ scoop install spicetify-autovolume

[BlockTheSpot](https://github.com/mrpond/BlockTheSpot) can be installed to block advertisements:

	$ scoop install blockthespot

All of the above packages can be updated through Scoop.

**If you don't care about reading any of this** and just want a quick way to install ad-blocked
Spotify with the Elementary theme, genius-spicetify, spicetify-autoVolume and developer tools,
copy and paste this into PowerShell:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install git sudo

scoop bucket add nerd-fonts
sudo scoop install Open-Sans Raleway --global

scoop bucket add spotify https://github.com/TheRandomLabs/Scoop-Spotify.git
scoop install spotify-latest blockthespot spicetify-cli spicetify-themes genius-spicetify spicetify-autovolume

spicetify config current_theme Elementary --quiet
spicetify-enable-devtool -quiet
```

**Or even shorter**, but with Adapta-Nokto instead:

```powershell
$ Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; iwr -useb https://raw.githubusercontent.com/TheRandomLabs/Scoop-Spotify/master/basic-setup.ps1 | iex
```

I wrote the above script mostly for people who don't care about using Scoop and just need a
foolproof way to set everything up automatically.

And in the future, if you want to update any installed packages:

```powershell
$ scoop update *
```

## Notes

* None of the packages in this bucket can be installed globally.
* If you have the means, please buy Spotify Premium instead of installing BlockTheSpot.
* All of the Spicetify packages require Spotify to be installed either through this Scoop bucket or
the official installer.
* All themes, extensions and custom apps for Spicetify are installed to `~\.spicetify` instead of
the spicetify-cli installation directory.
* Installing or updating any of the packages in this bucket automatically applies the Spicetify
configuration and preserves BlockTheSpot if it is installed.
* All Spicetify packages apart from spicetify-cli depend on spicetify-cli.
* `--purge` or `-p` should be used to fully uninstall all packages apart from `blockthespot`,
`google-spicetify` and `spicetify-themes`.

### BlockTheSpot

* This blocks advertisements for the latest version of Spotify.
* This package depends on `spotify-latest`.
* This is not an executable program. `spotify-latest` will be patched automatically every time this
package or any of the Spicetify packages are installed or updated.
* If BlockTheSpot is ever reset, `blockthespot` can be run to reapply it. This usually happens
after running Spicetify commands, and running `spicetify-apply` rather than `spicetify apply`
ensures that BlockTheSpot is enabled if it is installed.

### genius-spicetify

* Installing or updating genius-spicetify automatically applies the Spicetify configuration and
preserves BlockTheSpot if it is installed.
* See [here](https://github.com/khanhas/genius-spicetify#musicxmatch) to configure a custom
Musixmatch user token. `manifest.json` can be found at
`~\.spicetify\CustomApps\genius\manifest.json`.

### spicetify-autoVolume

* See
[here](https://github.com/amanharwara/spicetify-autoVolume#changing-the-intervalminimum-volume)
to modify the configuration. `autoVolume.js` can be found at
`~\.spicetify\Extensions\autoVolume.js`.

### spicetify-cli

* Experimental features, fast user switching and all
[default extensions](https://github.com/khanhas/spicetify-cli/wiki/Extensions) apart from
Auto Skip Videos, DJ Mode and Trash Bin are enabled by default.
* `spicetify-apply` is should be run instead of `spicetify apply` if BlockTheSpot is installed, as
it ensures that BlockTheSpot is enabled if it is installed.
* It should be noted that `spicetify-apply` also runs `spicetify restore` and `spicetify backup`
before running `spicetify apply` to ensure that changes are applied every time.
* For similar reasons, `spicetify-enable-devtool` and `spicetify-disable-devtool` should be run
instead of `spicetify enable-devtool` and `spicetify disable-devtool`.
* The three above commands also support the `-quiet` switch.
* To remove a custom app from the configuration, run:

```powershell
$ spicetify-config-remove custom_apps <app>
```

* To remove an extension from the configuration, run:

```powershell
$ spicetify-config-remove extensions <extension>
```

### spicetify-themes

* The [Elementary](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Elementary)
theme requires the Open Sans and Raleway fonts:

```powershell
$ scoop bucket add nerd-fonts
$ sudo scoop install Open-Sans Raleway
```

* The [WintergatanBlueprint](https://github.com/morpheusthewhite/spicetify-themes/tree/master/WintergatanBlueprint)
theme requires the Ubuntu font:

```powershell
$ scoop bucket add nerd-fonts
$ sudo scoop install Ubuntu-NF
```

### Spotify with BlockTheSpot

* This is an outdated version of Spotify (1.1.4.197.g92d52c4f) with an
[old version of BlockTheSpot](https://github.com/master131/BlockTheSpot).
* Spotify's built-in updater is disabled.
* This should only be used if BlockTheSpot does not work with the latest version of Spotify.
* Spotify with BlockTheSpot should be installed locally and not globally.
* Installation and uninstallation of this package require administrator privileges.
* This cannot be installed concurrently with `spotify-latest`.

### Spotify (latest)

* This is the latest version of Spotify.
* Unlike [Ash258's version](https://github.com/Ash258/scoop-Ash258/blob/master/bucket/Spotify.json),
this version installs completely silently and to the Scoop directory.
* Spotify's built-in updater is disabled, and Scoop should be used to update it instead.
* Spotify should be installed locally and not globally.
* This cannot be installed concurrently with `spotify-with-blockthespot`.
