gset () {
	key="$1"
	type="$2"
	value="$3"
	gconftool-2 --set "$key" --type "$type" -- "$value"
}

gset-bool () {
	key="$1"
	value="$2"
	gset "$key" "boolean" "$value"
}

gset-string () {
	key="$1"
	value="$2"
	gset "$key" "string" "$value"
}

gset-int () {
	key="$1"
	value="$2"
	gset "$key" "int" "$value"
}

gset-float () {
	key="$1"
	value="$2"
	gset "$key" "float" "$value"
}

gset-command () {
	n="$1"
	shortcut="$2"
	command="$3"
	
	gset-string "/apps/metacity/global_keybindings/run_command_$n" "$shortcut"
	gset-string "/apps/metacity/keybinding_commands/command_$n" "$command"
}

echo "Nautilus"
gset-string /apps/nautilus/preferences/show_icon_text never
gset-bool /apps/nautilus/preferences/start_with_sidebar false
gset-string /apps/nautilus/preferences/preview_sound never

echo "Clock applet"
gset-string /apps/panel/applets/clock_screen0/prefs/format '24-hour'
gset-bool /apps/panel/applets/clock_screen0/prefs/show_date false
gset-bool /apps/panel/applets/clock_screen0/prefs/show_temperature true

echo "Gnome Terminal"
gset-bool /apps/gnome-terminal/global/use_mnemonics false
gset-string /apps/gnome-terminal/keybindings/set_terminal_title "<Alt>t"
gset-string /apps/gnome-terminal/keybindings/next_tab "<Alt>Right"
gset-string /apps/gnome-terminal/keybindings/prev_tab "<Alt>Left"
gset-string /apps/gnome-terminal/keybindings/reset_and_clear "<Alt>r"
gset-string /apps/gnome-terminal/keybindings/reset_and_clear "<Alt><Shift>r"
gset-string /apps/gnome-terminal/keybindings/help ""

gset-bool /apps/gnome-terminal/profiles/Default/default_show_menubar false
gset-int /apps/gnome-terminal/profiles/Default/scrollback_lines 500000
gset-bool /apps/gnome-terminal/profiles/Default/use_theme_colors false
gset-string /apps/gnome-terminal/profiles/Default/background_color black
gset-string /apps/gnome-terminal/profiles/Default/foreground_color white
gset-bool /apps/gnome-terminal/profiles/Default/silent_bell true

echo "Desktop"
#gset-string /desktop/gnome/interface/monospace_font_name "Liberation Mono 9"
gset-string /desktop/gnome/interface/monospace_font_name "DejaVu Sans Mono 9"
gset-string /apps/metacity/general/button_layout "menu:minimize,maximize,close"

echo "Shortcuts"
gset-command 1 "<Super>n" "nedit"
gset-command 2 "<Super>g" "gedit"
gset-command 3 "<Super>slash" "gnome-terminal"
gset-command 4 "<Super>h" "devhelp"
gset-command 5 "<Super>t" "$HOME/bin/toggle-touchpad"
gset-command 6 "<Super>w" "gnome-dictionary"
gset-command 7 "<Super>c" "gnome-calculator"

echo "Gedit"
gset-bool /apps/gedit-2/preferences/editor/auto_indent/auto_indent trur
gset-bool /apps/gedit-2/preferences/editor/bracket_matching/bracket_matching true
gset-bool /apps/gedit-2/preferences/editor/current_line/highlight_current_line true
gset-bool /apps/gedit-2/preferences/editor/line_numbers/display_line_numbers true
gset-bool /apps/gedit-2/preferences/editor/right_margin/display_right_margin true
gset-bool /apps/gedit-2/preferences/editor/save/create_backup_copy false
gset-int /apps/gedit-2/preferences/editor/undo/max_undo_actions -1
gset-string /apps/gedit-2/preferences/editor/wrap_mode/wrap_mode GTK_WRAP_NONE


echo "Others"
gset-bool /apps/totem/show_vfx false
gset-float /apps/gwd/metacity_theme_opacity 1
gset-bool /apps/compiz/plugins/wall/allscreens/options/allow_wraparound true
