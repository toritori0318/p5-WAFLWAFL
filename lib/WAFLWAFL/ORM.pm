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

sub schema {
    my ($self) = @_;
    if ($self->schema_class){
        my $schema_class = $self->schema_class;
        $schema_class->require or die "[$schema_class] $!";
        return $schema_class;
    }
}

sub schemas {
    die 'die schemas';
}
sub schema_info {
    die 'die schema_info';
}
sub pk {
    die 'die pk';
}
sub columns {
    die 'die columns';
}

1;
__END__

=head1 NAME

WAFLWAFL::ORM - ORM Base Class

=head1 Accessor

=over

=item schema_class

Schema Class Name.

=back

=head1 METHODS

=over

=item schema

Schema Class Instance.

=item schemas

schemas.

=item schema_info

schema_info.

=item pk

get primary key column.

=item columns

get columns.

=back

=cut

