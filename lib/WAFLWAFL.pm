package WAFLWAFL;

use strict;
use warnings;

our $VERSION = '0.01';

use WAFLWAFL::ORM;
use WAFLWAFL::WAF::Controller;
use WAFLWAFL::WAF::View;

use Class::Accessor::Lite rw => [ qw(conf)] ;
use String::CamelCase qw(camelize);
use autodie;
use File::Spec;
use File::Path qw/mkpath/;
use Text::Xslate;
use UNIVERSAL::require;

sub new {
    my ($class, $p) =@_;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    my $config = do $p->{conf} or die "Cannot load configuration file: $p->{conf}";
    $args{'conf'} = $config;
    my $self = bless {
        %args,
    }, $class;
}

sub run {
    my ($class) = @_;
    my $config = $class->conf;
    my %prm;
    $prm{output} = $config->{OUTPUT} || "crudsample";
    if($config->{TMPL}) {
        $prm{src} = $config->{TMPL}->{src};
        $prm{c}   = $config->{TMPL}->{controller};
        $prm{v}   = $config->{TMPL}->{view};
    } else {
        die "require config value [TMPL]";
    }
    $class->proc(WAFLWAFL::WAF::Controller->new(\%prm));
    $class->proc(WAFLWAFL::WAF::View->new(\%prm));
}

sub proc {
    my ($class, $waf) = @_;
    my $config = $class->conf;

    $class->_mkdir(File::Spec->catfile($waf->output, $waf->dir));

    my $tx = Text::Xslate->new( path => [$waf->src] );
    my $orm = WAFLWAFL::ORM->new(
        {
            module       => $config->{ORM}->{module},
            schema_class => $config->{ORM}->{schema_class},
        }
    );
    my @schemas = $orm->schemas;
    for my $table (@schemas) {
        my $pk   = $orm->pk($table);
        my $cols = $orm->columns($table);
        for my $template (@{$waf->templates}){
            my $data = $tx->render(
                "$template.tx",
                {
                    package => camelize($table),
                    table   => $table,
                    pk      => $pk,
                    cols    => $cols,
                }
            );
            $class->_mkdir($waf->output_template_dir($table));
            $class->_mkfile($waf->output_template_file($table, $template), $data);
        }
    }
}

sub _mkdir {
    my ($class, $dir) = @_;
    unless (-d $dir) {
        print "mkdir $dir\n";
        mkpath $dir;
    }
}

sub _mkfile {
    my ($class, $file, $data) = @_;
    print "create file $file\n";
    open my $fh, ">", $file;
    print $fh $data;
    close $fh;
}


# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

WAFLWAFL - Perl extension for blah blah blah

=head1 SYNOPSIS

  use WAFLWAFL;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for WAFLWAFL, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

torii, E<lt>torii@mshome.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by torii

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
