# Script: polybar-windows

A [Polybar](https://github.com/jaagr/polybar) script that shows opened and minimized windows on your current display (if there's an active window it's marked by #). You can click on any window title to switch on that window (or expand minimized window).

Simple version:

![polybar-windows](screenshots/polybar-windows.png)

Decorated version:

![polybar-windows](screenshots/polybar-windows-decorated.png)

## Dependencies

* `xprop`
* `wmctrl`

## Configuration

Comment 'Decorated version' block and uncomment 'Simple version' block to switch on simple version.

## Module

```ini
[module/polybar-windows]
type = custom/script
exec = polybar-windows.sh
format = <label>
label = %output%
label-padding = 1
interval = 1
```
