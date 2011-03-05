package WAFLWAFL::Simple;

use strict;
use warnings;
use base qw(Exporter);
our @EXPORT = qw(proc);
use WAFLWAFL::ORM;
use Text::Xslate;

sub proc {
    my ($orm_module, $orm_class, $tmpl, $table) = @_;
    my $orm = WAFLWAFL::ORM->new(
        {
            module       => $orm_module,
            schema_class => $orm_class,
        }
    );
    my %vars = (
        pk      => $orm->pk($table),
        columns => $orm->columns($table),
        table   => $table,
    );
    $tmpl ||= '$column,';
    my $tx = Text::Xslate->new;
    my $template = qq| <: for \$columns -> \$column { :>$tmpl<: } :> |;
    print $tx->render_string($template, \%vars);
}

1;
__END__

=head1 NAME

WAFLWAFL::Simple - WAFLWAFL Simple Generater

=head1 SYNOPSIS

  # one liner
  perl -MWAFLWAFL::Simple -e 'proc("Skinny", "Skinny::Sample::DB", "<td><: \$column :></td>", "emp")'

=head1 DESCRIPTION

WAFLWAFL Simple Generater.

=head1 EXPORT FUNCTIONS

=item proc($orm_module, $orm_class, $tmpl, $table);

=head1 AUTHOR

torii

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
