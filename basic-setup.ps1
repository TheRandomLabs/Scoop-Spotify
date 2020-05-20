Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/lukesampson/scoop/master/bin/install.ps1')

scoop install git

scoop bucket add spotify https://github.com/TheRandomLabs/Scoop-Spotify.git
scoop install spotify-latest blockthespot spicetify-cli spicetify-themes genius-spicetify spicetify-autovolume

spicetify config current_theme Adapta-Nokto --quiet
spicetify-enable-devtool -quiet
