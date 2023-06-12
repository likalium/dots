# :sparkles: **Like a dot** :sparkles:
## Hello
Here you'll find my dotfiles, and a detailled description for each of them. I hope you'll like them!

> Note: Using them means you know how to manage them. So you can open issues but please, read documentation before complaining.
> Also, dont forget to read the manpages. [Arch manpages](https://man.archlinux.org)

## :computer: Eww \[WIP\]

<details>
  
  A [topbar](./eww) made with Eww. It was made for my (small) laptop, so feel free to adapt it to your screen. Note that it was made for wayland, so you must made some changes to make it work on X11.
  
  ### Requirements
  
  - Eww built with wayland support
  
  ### Useful infos
  
  > The weather widget needs you to have a OpenWeatherMap account (for access to the API). Create one [here](https://home.openweathermap.org/users/sign_up). <br>
  Also you'll need your latitude and longitude: get them [here](https://www.latlong.net/)
  
  **Documentation:** [Eww official documentation](https://elkowar.github.io/eww/eww.html) - [dharmx powermenu tutorial](https://dharmx.is-a.dev/eww-powermenu/)
  
  ### TODO
  
  - Finish this bar lmao
  - A Eww powermenu
  
</details>

## :star: Hyprland config
<details>
  
  A [Hyprland config](./hypr) using the [Nord colorscheme](https://www.nordtheme.com/). Don't forget to check the `hypr/hyprbinds` file to know all binds (if fact it's way better to check all files, but at least you must know the binds since without them you'll not be able to use this config).
  
  ### Requirements
  
  - The latest Hyprland (in fact you can use an older hyprland, but you'll probably lack some functionnalities)
  - Kitty (you don't ABSOLUTELY need it but it's a default terminal for this config, so it's useful)
  - All other stuff required by the bindings which launch apps (firefox,thunar, webcord) but feel free to change them
  
  ### Useful infos
  > Most important bindings (if you're absolutely lost): `Super+Return` opens Kitty; `Super+Q` closes Hyprland.
  
</details>

## :notes: Mpd & Ncmpcpp
<details>
  
  The Mpd config and Ncmpcpp config works together. I mean, you can use the Mpd config with another client, there's no problem, but this Mpd config was made for Ncmpcpp. That's all.

  ### Requirements

  - Mpd
  - Ncmpcpp
  
  ### Useful infos
  
  > By default, there's a fifo output (for the Ncmpcpp visualizer), a pipewire output, and a pulseaudio output. Feel free to add or remove some of them.<br>
  This config addionaly requires you to create the `~/.mpd` directory, and to create a file named `database` inside. You can choose other names, but in this case you'll must change the config options to these new locations/filenames.<br>
  This suposes that your music folder is `~/Music`. Don't forget to change it needed.
  
  **Documentation:** [Mpd Archwiki](https://wiki.archlinux.org/title/Music_Player_Daemon) - [Mpd Archwiki tips](https://wiki.archlinux.org/title/Music_Player_Daemon/Tips_and_tricks) - [Mpd Archwiki troubleshooting](https://wiki.archlinux.org/title/Music_Player_Daemon/Troubleshooting) - [Ncmpcpp archwiki](https://wiki.archlinux.org/title/Ncmpcpp)
  
</details>

## :telescope: Rofi

<details>
  This is a [small configuration](./rofi) for the [Rofi wayland](https://github.com/lbonn/rofi) fork by lbonn which uses the [Nord](https://www.nordtheme.com/) color palette. There's nothing special about it, I made that, that's all.
  
  ### Requirements
  - Rofi (wayland fork, or you'll must change some minor things)
  - Phosphor Icons 2.0 (for the icons)
  
  ### Useful infos
  
  > The icon theme I use with this is Zafiro Icons Dark, i think it goes very well with it.
  
  **Documentation:** [Rofi wayland](https://github.com/lbonn/rofi) - [Rofi](https://github.com/davatorium/rofi)
  
</details
