package WAFLWAFL::ORM;
use strict;
use warnings;
use Class::Accessor::Lite rw => [ qw(schema_class)] ;

sub new {
    my ($class, $p) =@_;
    die "die ORM" unless $p->{module};

    my $subclass = join '::', $class, $p->{module};
    eval "use $subclass"; ## no critic
    die $@ if $@;
    bless {%$p}, $subclass;
}

sub schemas {
    die 'die schemas';
}
sub pk {
    die 'die pk';
}
sub columns {
    die 'die columns';
}

1;



