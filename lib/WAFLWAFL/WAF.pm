package WAFLWAFL::WAF;
use strict;
use warnings;
use Class::Accessor::Lite new => 1, rw => [ qw(app output src cv)] ; 

sub templates {
    die 'die templates';
}

sub dir {
    die 'die dir';
}

sub file {
    die 'die file';
}

sub output_ext {
    die 'die output_ext';
}

sub output_template_dir {
    die 'die output_template_dir';
}

sub output_template_file {
    die 'die output_template_file';
}

1;
__END__

=head1 NAME

WAFLWAFL::WAF - WAF Base Class

=head1 Accessor

=over

=item app

Application Name.

=item output

Output Directory.

=item src

Input Template src.

=item cv

stash.

=back

=head1 METHODS

all abstract...

=over

=item templates

Specify tempalte file.

=item dir

Specify input tempalte directory.

=item file

Specify input tempalte file.

=item output_ext

Specify output file extension.

=item output_template_dir

Specify output directory.

=item output_template_file

Specify output file.

=back

=cut
