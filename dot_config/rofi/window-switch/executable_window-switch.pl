#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use JSON;
use Getopt::Std;
use IPC::Open2;

my $usage = "Usage: $0 -[fcm]\n";
getopts("fcm", \my %options) or die $usage;
my %arg = reverse %options or die $usage;
my $mode = $arg{1} || die $usage;

my $clients_json = qx(hyprctl -j clients);
my $activeworkspace_json = qx(hyprctl -j activeworkspace);
my $clients = decode_json $clients_json;
my $activeworkspace = decode_json $activeworkspace_json;
my $workspacename = $activeworkspace->{name};

my @sortedwindows = sort {$a->{focusHistoryID} <=> $b->{focusHistoryID}} @$clients;
my (@addressarr, @menuarr);
my $i = 0;

foreach my $window (@sortedwindows){
    if ($window->{title}){
        push @addressarr, $window->{address};
        my $ws_name = $window->{workspace}{name};
        $ws_name =~ s/special:magic/special/; 
        my $ws = "workspace:" . $ws_name;
        push @menuarr, sprintf("%-4d %-20s %s", $i++, $ws, $window->{title});
    }
}

my $menu = join "\n", @menuarr;
my %promt = (f => "focuswindow", c => "close window", m => "movetoworkspace $workspacename");

my $rofi_theme = "$ENV{HOME}/.config/rofi/window-switch/window-switch.rasi";
my @rofi_cmd = ('rofi', '-dmenu', '-i', '-theme', $rofi_theme, '-p', $promt{$mode});

my $pid = open2(my $rofi_out, my $rofi_in, @rofi_cmd) or die "Could not run rofi: $!\n";
print $rofi_in $menu;
close $rofi_in; 

my $out = <$rofi_out>;
waitpid($pid, 0);

exit unless defined $out;

my $index = (split /\s+/, $out)[0];
exit unless defined $index && $index =~ /^\d+$/;

my $dest = $addressarr[$index] or die "Invalid selection.\n";
my %hyprdispatchs = (
    f => ["hyprctl", "dispatch", "focuswindow", "address:$dest"],
    c => ["hyprctl", "dispatch", "closewindow", "address:$dest"],
    m => ["hyprctl", "--batch", "dispatch focuswindow address:$dest; dispatch movetoworkspace $workspacename"]
);

exec $hyprdispatchs{$mode}->@*;
