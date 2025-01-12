#!/usr/bin/env bash

# PS4='$LINENO: '
# set -x

RUNCMD=`realpath $0`
RUNDIR=`dirname $RUNCMD`
cd "$RUNDIR"

LOGDIR="$RUNDIR/temp"
RUNTIME=`jdate +%Y%m%d%H%M%S 2> /dev/null || date +%Y%m%d%H%M%S`
LOGFILE="$LOGDIR/$RUNTIME.log"
ERRFILE="$LOGDIR/$RUNTIME.err"
mkdir -p "$LOGDIR"

gnome_reset(){
    rm -f  ~/.config/monitors.xml
    dconf reset -f /org/gnome/
    gsettings reset-recursively org.gnome.shell
}
gnome_set(){
    # View current settings - gsettings list-recursively org.gnome.desktop.interface
    profile="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/"
    gsettings reset-recursively   "$profile" 
    gsettings set "$profile" "background-color" 'rgb(0,0,0)'
    gsettings set "$profile" "default-size-columns" 220
    gsettings set "$profile" "default-size-rows" 220
    gsettings set "$profile" "font" 'Monospace 16'
    gsettings set "$profile" "foreground-color" 'rgb(0,255,0)'
    gsettings set "$profile" "background-color" 'rgb(0,0,0)'
    gsettings set "$profile" "use-system-font" false
    gsettings set "$profile" "use-theme-colors" false
    gsettings set "$profile" audible-bell false
    gsettings set "$profile" scrollback-unlimited true    

    # Font Settings
    gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans 11'
    gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 12'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans 11'

    # Other Settings
    gsettings set org.gnome.desktop.interface clock-format '24h'
    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-seconds true
    gsettings set org.gnome.desktop.interface clock-show-weekday true

    # Enable window buttons
    gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

    # Set new windows centered
    gsettings set org.gnome.mutter center-new-windows true

    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.desktop.interface color-scheme 'default'

    # nautilus file explorer
    gsettings set org.gnome.nautilus.preferences show-create-link true
    gsettings set org.gnome.nautilus.preferences show-delete-permanently true
    gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
    gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'

    # favorite-apps
    gsettings set org.gnome.shell favorite-apps \
    "['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'codium.desktop', 'xfce4-appfinder.desktop', 'com.raggesilver.BlackBox.desktop', 'org.gnome.TextEditor.desktop', 'org.mozilla.firefox.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Calculator.desktop', 'winbox.desktop', 'org.gnome.Settings.desktop', 'org.gnome.SystemMonitor.desktop', 'org.gnome.tweaks.desktop', 'putty.desktop', 'xed.desktop', 'org.gnome.gedit.desktop', 'vlc.desktop', 'org.remmina.Remmina.desktop', 'org.gnome.Software.desktop', 'org.telegram.desktop.desktop', 'virt-manager.desktop', 'gns3.desktop']"

    # keyboard inouts
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ir')]"
    gsettings set org.gnome.desktop.input-sources per-window true

    gsettings set org.gnome.gnome-system-monitor current-tab 'resources'
    gsettings set org.gnome.gnome-system-monitor cpu-stacked-area-chart true
    gsettings set org.gnome.gnome-system-monitor graph-data-points 600
    gsettings set org.gnome.gnome-system-monitor logarithmic-scale true
    gsettings set org.gnome.gnome-system-monitor network-in-bits true
    gsettings set org.gnome.gnome-system-monitor network-total-in-bits false
    gsettings set org.gnome.gnome-system-monitor update-interval 1000

    gsettings set org.gnome.gedit.plugins active-plugins "['spell', 'sort', 'pythonconsole', 'modelines', 'filebrowser', 'docinfo']"
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor auto-save-interval "uint32 1"
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor scheme 'classic'
    gsettings set org.gnome.gedit.preferences.editor tabs-size "uint32 4"
    gsettings set org.virt-manager.virt-manager system-tray true
    gsettings set org.virt-manager.virt-manager xmleditor-enabled true
    gsettings set org.gnome.shell last-selected-power-profile 'performance'

    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

    gsettings set org.gnome.desktop.interface icon-theme 'Win11-blue'


    timeout 1 tilix &> /dev/null
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-color "'#000000000000'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/background-transparency-percent 0
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/badge-color "'#AC7EA8'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/badge-color-set false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/bold-color-set false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/bold-is-bright true
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/cursor-colors-set false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/default-size-columns 200
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/default-size-rows 200
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/dim-transparency-percent 0
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font "'Monospace 16'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/foreground-color "'#0000FFFF0000'"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/highlight-colors-set false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/palette "['#272822', '#F92672', '#A6E22E', '#F4BF75', '#66D9EF', '#AE81FF', '#A1EFE4', '#F8F8F2', '#75715E', '#F92672', '#A6E22E', '#F4BF75', '#66D9EF', '#AE81FF', '#A1EFE4', '#F9F8F5']"
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-system-font false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/use-theme-colors false
    dconf write /com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/visible-name "'default'"
    dconf write /com/gexperts/Tilix/theme-variant "'dark'"
}
mytheme(){

    mkdir -p ~/.config/

    # configuring mimeapps
    if [ -f "$RUNDIR/desktop.files/mimeapps.list" ] ; then
        cd $RUNDIR/desktop.files/
        cat "$RUNDIR/desktop.files/mimeapps.list" > ~/.config/mimeapps.list
    fi
    # copying favorite wallpapers
    if [ -f $RUNDIR/desktop.files/wallpapers.tar.xz ] ; then 
        cd $RUNDIR/desktop.files/
        tar -xf wallpapers.tar.xz
        cp -ru wallpapers/* ~/Pictures/my.wallpapers/
        rm -rf wallpapers/
    fi

    # setting random wallpaper script
    if [ -f "$RUNDIR/desktop.files/set.bg.pic.sh" ] ; then
        cd $RUNDIR/desktop.files/
        mkdir -p ~/.scripts/ ~/Pictures/my.wallpapers
        cat "$RUNDIR/desktop.files/set.bg.pic.sh" > ~/.scripts/set.bg.pic.sh
        chmod +x ~/.scripts/set.bg.pic.sh
    fi

    # copying favorite fonts
    if [ -f $RUNDIR/fonts.tar.xz ] ; then 
        mkdir -p ~/.fonts
        cd $RUNDIR/desktop.files/
        tar -xf fonts.tar.xz
        cp -ru fonts/* ~/.fonts/
        rm -rf fonts/
    fi

    # copying favorite icons
    if [ -f $RUNDIR/icons.tar.xz ] ; then 
        mkdir -p ~/.icons
        cd $RUNDIR/desktop.files/
        tar -xf icons.tar.xz 
        cp -ru icons/* ~/.icons/
        rm -rf icons/
    fi
    cd $RUNDIR
}
my_gnome_ext(){

    # starting by installing gnome-extensions-cli
    GEC=`which gnome-extensions-cli 2> /dev/null | grep -icw gnome-extensions-cli`
    PIP=`which pip3 2> /dev/null | grep -icw pip3`
    if [ "$GEC" -eq "0" ] ; then
        if [ "$PIP" -eq "0" ] ; then
            sudo install python3-pip -y 
        fi
            pip3 install gnome-extensions-cli -y
    fi

    # disable all extensions
    gnome-extensions list | xargs -n 1 gnome-extensions disable -q

    # installing some extensions
    gnome-extensions-cli install dash-to-panel@jderose9.github.com
    gnome-extensions-cli install EasyScreenCast@iacopodeenosee.gmail.com
    gnome-extensions-cli install PersianCalendar@oxygenws.com
    gnome-extensions-cli install appindicatorsupport@rgcjonas.gmail.com

    # enabling extensions
    gnome-extensions enable -q dash-to-panel@jderose9.github.com
    gnome-extensions enable -q EasyScreenCast@iacopodeenosee.gmail.com
    gnome-extensions enable -q PersianCalendar@oxygenws.com
    gnome-extensions enable -q appindicatorsupport@rgcjonas.gmail.com

    # configuring extension: dash to panel
    if [ -f "$RUNDIR/desktop.files/dash_to_panel.conf" ] ; then
        cd $RUNDIR/desktop.files/
        dconf load /org/gnome/shell/extensions/dash-to-panel/ < "$RUNDIR/desktop.files/dash_to_panel.conf"
    fi

    # configuring extension: persian-calendar 
    dconf write /org/gnome/shell/extensions/persian-calendar/widget-format "'%D %MM ماه %Y'"
    dconf write /org/gnome/shell/extensions/persian-calendar/index "3"
    dconf write /org/gnome/shell/extensions/persian-calendar/position "'center'"
    dconf write /org/gnome/shell/extensions/persian-calendar/startup-notification "'false'"
}
#


if [ "`echo $@ | grep -iwc reset`" -gt "0" ] ; then gnome_reset ; fi
gnome_set
my_theme
my_gnome_ext
