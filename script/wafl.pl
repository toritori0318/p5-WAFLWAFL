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
    $conf = do $conf or die "Cannot load configuration file: $conf";
    WAFLWAFL->new({conf => $conf})->run;
}

main();
exit;

__END__

=head1 NAME

wafl-.pl - Run Minimal CRUD generator

=head1 USAGE

wafl.pl [OPTION]

wafl.pl --conf='config.pl'

=head1 OPTIONS

=over 4

=item --conf

config file

  example.

    use File::Spec;
    my $app = 'MyApp';
    +{
        'APP'    => $app,
        'OUTPUT' => 'crudsample',
        'ORM' => {
            module       => 'Skinny',
            schema_class => 'Skinny::Sample::DB',
        },
        'TMPL' => {
            src => File::Spec->catfile('eg', 'templates-amon'),
            dispatcher => {
                file => File::Spec->catfile('lib', $app, 'Web', "Dispatcher.pm.sample"),
            },
            controller => {
                dir => File::Spec->catfile('lib', $app, 'Web', 'C'),
            },
            view => {
                dir => "tmpl",
                ext => ".tt",
            },
        },
    };

=item  --help

help

=back

=head1 PREPARATION

dispatcher (Output 1 file)

  dispatcher.tx

controller (Output per table)

  controller.tx

view (Output per table)

  create.tx
  edit.tx
  delete.tx
  list.tx

=head1 CONFIG VALIABLE

=over

=item APP

Application Name.

=item OUTPUT

output directory.

=item ORM->{module}

Specify WAFLWAFL::ORM::XXXXX (Skinny / DBIC ...)

=item ORM->{schema_class}

OR/Mapper Schema Class

=item TMPL->{src}

Specify input template directory.

=item TMPL->{dispatcher}->{file}

Specify output dispatcher file.

=item TMPL->{controller}->{dir}

Specify output controller dirrectory.

=item TMPL->{view}->{dir}

Specify output view dirrectory.

=item TMPL->{view}->{ext}

Specify output view file extension.

=back

=cut

