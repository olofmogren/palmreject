# Palm rejection for bash and xinput

The code is tested on Ubuntu 16.04.1 with Gnome 3.

Depends only on bash and xinput.

Turns off touchscreen when stylus is near screen.

Stylus status is checked every 100 ms.

You need to check the ids for your devices.
Run "xinput list" on your system and edit the
first lines in palmreject.sh.
Then run the script every time you login.

