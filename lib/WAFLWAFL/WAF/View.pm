package WAFLWAFL::WAF::View;
use strict;
use warnings;
use parent 'WAFLWAFL::WAF'; 

sub templates {
    my $self = shift;
    return [qw/create delete edit list/];
}

sub dir {
    my $self = shift;
    return $self->v;
}

sub ext {
    my $self = shift;
    return '.tx';
}

sub output_template_dir {
    my ($self, $table) = @_;
    return File::Spec->catfile($self->output, $self->dir, $table);
}

sub output_template_file {
    my ($self, $table, $file) = @_;
    return File::Spec->catfile($self->output, $self->dir, $table, $file.$self->ext);
}

1;



