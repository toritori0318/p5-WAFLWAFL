#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use autodie;
use WAFLWAFL;

GetOptions(
    'conf=s' => \my $conf,
    'help'   => \my $help,
) or pod2usage(0);
pod2usage(1) if $help;

sub main {
    $conf ||= "config.pl";
    my $waf = WAFLWAFL->new({conf => $conf});
    $waf->run();
    #WAFLWAFL->run($conf); 
}

main();
exit;

__END__

=head1 SYNOPSIS

    % crud.pl MyApp


These options are available for all commands:
    --config <path> Path to your applications home directory, defaults to config.pl
=head1 AUTHOR

Tokuhiro Matsuno

=cut


