#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use autodie;
use WAFLWAFL::Simple qw/proc/;

GetOptions(
    'conf=s'   => \my $conf,
    'module=s' => \my $orm_module,
    'class=s'  => \my $orm_class,
    'table=s'  => \my $table,
    'tmpl=s'   => \my $tmpl,
    'help'     => \my $help,
) or pod2usage(0);
pod2usage(1) if $help;

sub main {
    $conf ||= "config.pl";
    if(-f $conf){
        my $config = do $conf or die "Cannot load configuration file: $conf";
        proc(
            $config->{module},
            $config->{class},
            $config->{table},
            $config->{tmpl},
        );
    }else{
        proc(
            $orm_module,
            $orm_class,
            $table,
            $tmpl,
        );
    }
}

main();
exit;

__END__

=head1 NAME

wafl-simple.pl - Run WAFLWAFL Simple

=head1 USAGE

wafl-simple.pl [OPTION]

wafl-simple.pl --module='Skinny' --class='Skinny::Sample::DB' --table='emp' --tmpl='<: $column :>,'

=head1 OPTIONS

=over 4

=item --module

WAFLWAFL::ORM::XXXXX (Skinny / DBIC ...)

=item --class

OR/Mapper Schema Class

=item --table

table (Schema) name

=item --tmpl

Templates for each column (default -> <: $column :>, )

=item --conf

config file

  example.
  +{
      module     => 'Skinny',
      class      => 'Skinny::Sample::DB',
      table      => 'emp',
      tmpl       => '<: \$column :>,',
  };

=item  --help

help

=back

=head1 Template Examples

=over 4

=item Sample Schema

  CREATE TABLE DEPT
  (
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13),
    constraint pk_dept primary key(deptno)
  );

=item Simple

template

  tmpl => '<: $column :>,',

result.

  deptno,dname,loc,

=item SQL Bind Uptdate

template

  tmpl => '<: $column :>=?,' . "\n",

result.

  deptno=?,
  dname=?,
  loc=?,

=item SQL Bind Where

template

  tmpl => '<: $column :>=? and' . "\n",

result.

  deptno=? and
  dname=? and
  loc=? and

=item Lexical var

template

  tmpl => '<: $column :>,',

result.

  my $deptno = shift;
  my $dname = shift;
  my $loc = shift;

=item Getter / Setter

template

    tmpl => q|
sub <: $column :> {
    my $self = shift;
    if(@_) {
        $self->{<: $column :>} = $_[0];
    }
    return $self->{<: $column :>};
}
|,

result.

  sub deptno {
      my $self = shift;
      if(@_) {
          $self->{deptno} = $_[0];
      }
      return $self->{deptno};
  }

  sub dname {
      my $self = shift;
      if(@_) {
          $self->{dname} = $_[0];
      }
      return $self->{dname};
  }

  sub loc {
      my $self = shift;
      if(@_) {
          $self->{loc} = $_[0];
      }
      return $self->{loc};
  }

=back

=cut

