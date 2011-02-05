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
    return $self->v->{dir} or die 'die view config [dir]';
}

sub file {
    return;
}

sub ext {
    my $self = shift;
    return $self->v->{ext} || '.tt';
}

sub output_template_file {
    my ($self, $table, $file) = @_;
    return File::Spec->catfile($self->output, $self->dir, lc($table), $file.$self->ext);
}

1;



