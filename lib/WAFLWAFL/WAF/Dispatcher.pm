package WAFLWAFL::WAF::Dispatcher;
use strict;
use warnings;
use parent 'WAFLWAFL::WAF'; 
use String::CamelCase qw(camelize);

sub templates {
    my $self = shift;
    return [qw/dispatcher/];
}

sub dir {
    return;
}

sub file {
    my $self = shift;
    return $self->cv->{file} or die 'die dispatcher config [file]';
}

sub output_ext {
    return;
}

sub output_template_file {
    my ($self) = @_;
    return File::Spec->catfile($self->output, $self->file);
}

1;



