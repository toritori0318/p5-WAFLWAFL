package WAFLWAFL::ORM::Skinny;
use strict;
use warnings;
use parent 'WAFLWAFL::ORM';
use UNIVERSAL::require;

sub schema {
    my ($self) = @_;
    if ($self->schema_class){
        my $schema_class = $self->schema_class;
        $schema_class->require;
        return $schema_class;
    }
}

sub schema_info {
    my ($self) = @_;
    my $schema = $self->schema;
    return $schema->schema->schema_info if $schema;
}

sub schemas {
    my ($self) = @_;
    my $schema_info = $self->schema_info;
    return keys %{$schema_info} if $schema_info;
}

sub pk {
    my ($self, $table) = @_;
    my $schema_info = $self->schema_info;
    return $schema_info->{$table}->{pk} if $schema_info && $table ;
}
sub columns {
    my ($self, $table) = @_;
    my $schema_info = $self->schema_info;
    return $schema_info->{$table}->{columns} if $schema_info && $table ;
}

1;



