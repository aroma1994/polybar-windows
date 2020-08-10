![polywins](screenshots/demonstration.gif)

# Script: polywins
A [Polybar](https://github.com/jaagr/polybar) script forked from [polybar-windows](https://github.com/aroma1994/polybar-windows) with additional features. (Requires EWMH-compliancy)
* Left click: Focus window and raise it if it is minimized. If the window is already focused, minimize it.
* Middle click: Close the window.
* Right click: Select a rectangle for the window to be re-positioned to.
* Mouse wheel: Resize the window incrementally.

<sub>For a very limited multihead implementation, check out the [multihead branch](https://github.com/alnj/polywins/tree/multihead).</sub>


## Configuration

The following variables at the top of the file may be customized:
| Setting | Description |
| --- | --- |
| `active_text_color="#250F0B"` | Color of the name of the active window. |
| `active_bg=` | Background colour of active window. Leave empty if unwanted. |
| `active_underline="#ECB3B2"` | Underline colour of active window. Leave empty if unwanted. |
| `inactive_text_color="#250F0B"` | Color of the name of inactive windows. |
| `inactive_bg=` | Background colour of inactive windows. Leave empty if unwanted. |
| `inactive_underline=` | Underline colour of inactive windows. Leave empty if unwanted. |
| `separator="·"` | String displayed between window names. |
| `show="window_class"` | Whether to display window_title, window_class or window_classname. |
| `forbidden_classes="Polybar Conky Gmrun"` | Window classes that you do not wish to appear in the window list. |
| `empty_desktop_message="Desktop"` | String to display if no window is open. |
| `case="normal"` | normal, upper, lower. |
| `char_limit=20` | Maximum window name length after which it will be truncated. |
| ``max_windows=15`` | Maximum number of displayed windows. Useful if you have limited space. Will show how many windows are hidden. (e.g. `+3`)|
| `add_spaces="true"` | Whether to add a space to the side of each window name. |
| `resize_increment=16` | Size in pixel of resizing steps for the mouse wheel functions. |
| `wm_border_width=1` | Setting this variable might make resizing positions more accurate. |


## Installing

* Install `wmctrl`, it should be packaged by most distros. For example on Ubuntu and Debian-based distros, `sudo apt install wmctrl`
* Save `polywins.sh`, for example to `~/.config/polybar/scripts`
* Make the script executable with `chmod +x ~/.config/polybar/scripts/polywins.sh`
* Change any setting you wish at the top of the script
* Add the following module to your polybar config:
```ini
[module/polywins]
type = custom/script
exec = ~/.config/polybar/scripts/polywins.sh 2>/dev/null
format = <label>
label = %output%
label-padding = 1
tail = true
```
* Add the module to one of your bars, and don't forget to set a line-size if you intend to use underline, for example like so:
```ini
[bar/your_bar_name]
modules-center = polywins
line-size = 2
```

## Dependencies

* `xprop`
* `wmctrl`
* `slop` for rectangle-resizing
