################################################################################
## ~/.xinitrc

## ┬─┐┬─┐┌┌┐┐─┐
## │ ││─┘│││└─┐
## ┴─┘│  ┘ │──┘
########## DPMS

# adapt dpms according to AC state
status=`awk '/^state: / { print $2 }' /proc/acpi/ac_adapter/AC/state`
if [ "$status" = "off-line" ]
then
    # dpms
    xset s blank
    xset s 100
else
    xset s blank
    xset s 1200
fi

## ┬─┐┬─┐┌─┐┬┌ ┌─┐┬─┐┌─┐┬ ┐┌┐┐┬─┐
## │─││─┤│  ├┴┐│ ┬│┬┘│ ││ │││││ │
## ┴─┘┘ │└─┘│ ┘└─┘│└┘┘─┘└─┘ └┘┴─┘
###################### BACKGROUND

#xsetroot -mod 8 8 -bg black -fg gray10
wpsetters=feh fbsetbg -t ~/.wallpaper.png

## ┬ ┬o┬─┐┬─┐  ┌┌┐┐ ┬  ┌┌┐┌─┐┬ ┐┐─┐┬─┐
## │─┤││ │├─   │││└┌┘  ││││ ││ │└─┐├─ 
## │ ┴│┴─┘┴─┘  ┘ │ │   ┘ │┘─┘└─┘──┘┴─┘
######################## HIDE MY MOUSE

unclutter -root -idle 2 -jitter 10 &
unrat &

## ┬  ┌─┐┌─┐┬┌ 
## │  │ ││  ├┴┐
## └─┘┘─┘└─┘│ ┘
########## LOCK

if [ -x /usr/bin/sinac ] && [ "$(sinac -p)" -gt 300 ]; then
    slock
fi

## ┬─┐┬─┐┬─┐
## │─││─┤│┬┘
## ┴─┘┘ ││└┘
######## BAR

conky

## ┐─┐┬ ┐┬─┐┬┌ ┬─┐  ┬  o┬┌ ┬─┐  ┌┐┐┬─┐┬─┐┌┌┐
## │ ││ ││─┤├┴┐├─ ──│  │├┴┐├─    │ ├─ │┬┘│││
## └─\└─┘┘ ││ ┘┴─┘  └─┘││ ┘┴─┘   │ ┴─┘│└┘┘ │
############################ QUAKE-LIKE TERM

#yeahconsole &

## ┐ ┬o┌┐┐┬─┐┌─┐┐ ┬  ┌┌┐┬─┐┌┐┐┬─┐┌─┐┬─┐┬─┐
## ││││││││ ││ ││││  ││││─┤││││─┤│ ┬├─ │┬┘
## └┴┘│ └┘┴─┘┘─┘└┴┘  ┘ │┘ │ └┘┘ │└─┘┴─┘│└┘
########################### WINDOW MANAGER

#exec monsterwm
exec larswm
#exec ratpoison
#exec dwm
#exec w9wm -grey -nostalgia
