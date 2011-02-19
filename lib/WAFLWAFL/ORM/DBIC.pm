package WAFLWAFL::ORM::DBIC;
use strict;
use warnings;
use parent 'WAFLWAFL::ORM';
use String::CamelCase qw(camelize);
use UNIVERSAL::require;

sub schema_info {
    my ($self) = @_;
    my $schema = $self->schema;
    return $schema->sources if $schema;
}

sub schemas {
    my ($self) = @_;
    my @schema_infos = $self->schema_info;
    return @schema_infos if scalar @schema_infos > 0;
}

sub pk {
    my ($self, $table) = @_;
    my $schema = $self->schema;
    my @pks = $schema->source(camelize($table))->primary_columns;
    return $pks[0];
}

sub columns {
    my ($self, $table) = @_;
    my $schema = $self->schema;
    return [$schema->source(camelize($table))->columns];
}

1;
