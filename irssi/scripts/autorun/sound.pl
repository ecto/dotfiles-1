use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '0.0.3';
%IRSSI = (
        authors     => 'Chrelad',
        contact     => 'blah@blah.blah',
        name        => 'alert',
        description => 'Play sounds for different events in IRSSI.',
        url         => 'http://google.com',
        license     => 'GNU General Public License',
        changed     => '$Date: 2007-02-07 12:00:00 +0100 (Thu, 7 Feb 2008) $'
);

#--------------------------------------------------------------------
# Created by Chrelad
# Feb 7, 2008
#modified by Storm Dragon
#Added private message sound and the ability to select sound method
#Sounds now play as a background process.
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# The sound playing function for private message
#--------------------------------------------------------------------

sub pri_msg {
        my ($server,$msg,$nick,$address,$target) = @_;
        system("/usr/bin/aplay -q /home/f6k/t/TokyoTrainStation.AdiumSoundset/New.wav &");
}

#--------------------------------------------------------------------
# The sound playing function for nick mensioning message
#--------------------------------------------------------------------

sub nick_msg {
        my ($server,$msg,$nick,$address,$target) = @_;
        system("/usr/bin/aplay -q /home/f6k/t/TokyoTrainStation.AdiumSoundset/New.wav &");
}

#--------------------------------------------------------------------
# Irssi::signal_add_last / Irssi::command_bind
#--------------------------------------------------------------------

Irssi::signal_add("beep", "nick_msg");
Irssi::signal_add_last("message private", "pri_msg");
#- end

