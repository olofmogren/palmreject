# Palm rejection for bash and xinput

The code is tested on Ubuntu & Archlinux with Gnome 3.

Depends only on bash and xinput.

It turns off touchscreen input when stylus is near screen.

Stylus status is checked every 100 ms, a timeout is by
default set to 2 seconds for re-enabling the touchscreen
after stylus input.

## Configuration

You need to set up the names of the touchscreen and stylus devices.
Run "xinput list" on your system and edit the first lines in palmreject.sh.

To test, run the script with verbose=true.

## Install

Run the script every time you log in. For example in Gnome 3:

```bash
ln -s $PWD/palmreject.sh $HOME/.config/autostart/
ln -s $PWD/palmreject.desktop $HOME/.config/autostart/
```
