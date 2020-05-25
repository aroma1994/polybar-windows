#!/bin/sh
# POLYWINS

# SETTINGS {{{ ---

text_color="#250F0B"
underline_color="#E7A09E"
separator="·"
display=window_class # options: window_title, window_class, window_classname
case=lower # options: normal, upper, lower
add_spaces=true
char_limit=20
resize_increment=30

# --- }}}



# Setup
wm_border_width=0 # setting this might be required for accurate resize position
active_window_left="%{F$text_color}%{+u}%{u$underline_color}"
active_window_right="%{-u}%{F-}"

active_display=$(wmctrl -d | awk '/\*/ {print $1}')
active_window=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print "0x0"substr($5,3)}')

# On-click actions
case "$1" in
raise_or_minimize)
	shift
	if [ "${active_window}" = "${1}" ]; then
		wmctrl -ir "$1" -b toggle,hidden
	else
		wmctrl -ia "$1"
	fi
	exit
	;;
close)
	shift
	wmctrl -ic "$1"
	exit
	;;
slop_resize)
	shift
	wmctrl -ia "$1"
	wmctrl -ir "$1" -e "0,$(slop | awk -F'[x+]' '{print $3","$4","$1","$2}')"
	exit
	;;
increment_size)
	shift
	wmctrl -ir "$1" -e "$(wmctrl -G -l | \
		awk -v i="$resize_increment" \
		    -v b="$wm_border_width" \
		    -v win="$1" \
		'$1 ~ win {print "0,"$3-b*2-i/2","$4-b*2-i/2","$5+i","$6+i}')"
	exit
	;;
decrement_size)
	shift
	wmctrl -ir "$1" -e "$(wmctrl -G -l | \
		awk -v i="$resize_increment" \
			-v b="$wm_border_width" \
			-v win="$1" \
		'$1 ~ win {print "0,"$3-b*2+i/2","$4-b*2+i/2","$5-i","$6-i}')"
	exit
	;;
esac

# Generating the window list
window_list=$(wmctrl -lx|awk -vORS="" -vOFS="" \
	-v active_display="$active_display" \
	-v active_window="$active_window" \
	-v active_left="$active_window_left" \
	-v active_right="$active_window_right" \
	-v separator="$separator" \
	-v display="$display" \
	-v case="$case" \
	-v char_limit="$char_limit" \
	-v add_spaces="$add_spaces" \
	-v on_click="$0" \
	'{
	if ($2 != active_display && $2 != "-1") { next }
	if ($3 ~ "polybar" || $3 ~ "yad") { next }

	if (display == "window_class") {
		lastitem=split($3,classname_and_class,".")
		displayed_name = classname_and_class[lastitem]
	}
	else if (display == "window_classname") {
		split($3,classname_and_class,".")
		displayed_name = classname_and_class[1]
	}
	else if (display == "window_title") {
		title = ""; for (i = 5; i <= NF; i++) {
			title = title $i; if (i != NF) { title = title " "} }
		displayed_name = title
	}

	if      (case == "lower") { displayed_name = tolower(displayed_name) }
	else if (case == "upper") { displayed_name = toupper(displayed_name) }

	if (length(displayed_name) > char_limit) {
		displayed_name = substr(displayed_name,1,char_limit)"…"
	}

	if (add_spaces == "true") { displayed_name = " "displayed_name" " }

	if ($1 == active_window) {
		displayed_name=active_left displayed_name active_right
	}

	if (non_first == "") { non_first = "true" } else {
		print separator # only on non-first items
	}

	print "%{A1:"on_click" raise_or_minimize "$1":}"
	print "%{A2:"on_click" close "$1":}"
	print "%{A3:"on_click" slop_resize "$1":}"
	print "%{A4:"on_click" increment_size "$1":}"
	print "%{A5:"on_click" decrement_size "$1":}"
	print displayed_name
	print "%{A}%{A}%{A}%{A}%{A}"
	}')

echo "$window_list"
