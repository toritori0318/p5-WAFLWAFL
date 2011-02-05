package WAFLWAFL::WAF::Controller;
use strict;
use warnings;
use parent 'WAFLWAFL::WAF'; 
use String::CamelCase qw(camelize);

sub templates {
    my $self = shift;
    return [qw/controller/];
}

sub dir {
    my $self = shift;
    return $self->c->{dir} or die 'die controller config [dir]';
}

sub file {
    return;
}

sub ext {
    my $self = shift;
    return '.pm';
}

sub output_template_file {
    my ($self, $table, $file) = @_;
    return File::Spec->catfile($self->output, $self->dir, camelize($table).$self->ext);
}

1;



