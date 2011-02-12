package WAFLWAFL;

use strict;
use warnings;

our $VERSION = '0.01';

use WAFLWAFL::ORM;
use WAFLWAFL::WAF::Dispatcher;
use WAFLWAFL::WAF::Controller;
use WAFLWAFL::WAF::View;

use Class::Accessor::Lite new => 1, rw => [ qw(conf)] ;
use String::CamelCase qw(camelize);
use autodie;
use File::Spec;
use File::Path qw/mkpath/;
use File::Basename qw/dirname/;
use Text::Xslate;
use UNIVERSAL::require;

sub run {
    my ($class) = @_;
    my $config = $class->conf;

    my %prm;
    $prm{app}    = $config->{APP}    || "MyApp";
    $prm{output} = $config->{OUTPUT} || "crudsample";
    if($config->{TMPL}) {
        $prm{src} = $config->{TMPL}->{src};
        $prm{d}   = $config->{TMPL}->{dispatcher};
        $prm{c}   = $config->{TMPL}->{controller};
        $prm{v}   = $config->{TMPL}->{view};
    } else {
        die "require config value [TMPL]";
    }
    $class->proc(WAFLWAFL::WAF::Dispatcher->new(\%prm)) if $prm{d};
    $class->proc(WAFLWAFL::WAF::Controller->new(\%prm)) if $prm{c};
    $class->proc(WAFLWAFL::WAF::View->new(\%prm)) if $prm{v};
}

sub proc {
    my ($class, $waf) = @_;
    my $config = $class->conf;

    my $tx = Text::Xslate->new(
        function => { lc => sub { lc($_[0]) }, },
        path     => [$waf->src],
    );
    my $orm = WAFLWAFL::ORM->new(
        {
            module       => $config->{ORM}->{module},
            schema_class => $config->{ORM}->{schema_class},
        }
    );

    my $render = '';
    if($waf->file){
        my @schemas = $orm->schemas;
        for my $table (@schemas) {
            my $pk   = $orm->pk($table);
            my $cols = $orm->columns($table);
            for my $template (@{$waf->templates}){
                $render .= $tx->render(
                    "$template.tx",
                    {
                        app      => $waf->app,
                        package  => camelize($table),
                        table    => lc($table),
                        pk       => $pk,
                        cols     => $cols,
                        ext      => $waf->v->{ext},
                    }
                );
            }
        }
        $class->_mkfile($waf->output_template_file, $render);
    }else{
        my @schemas = $orm->schemas;
        for my $table (@schemas) {
            my $pk   = $orm->pk($table);
            my $cols = $orm->columns($table);
            for my $template (@{$waf->templates}){
                $render = $tx->render(
                    "$template.tx",
                    {
                        app      => $waf->app,
                        package  => camelize($table),
                        table    => lc($table),
                        pk       => $pk,
                        cols     => $cols,
                        ext      => $waf->v->{output_ext},
                    }
                );
                $class->_mkfile($waf->output_template_file($table, $template), $render);
            }
        }
    }
}

sub _mkfile {
    my ($class, $file, $data) = @_;
    my $dir  = dirname($file);
    if ($dir && not(-d $dir)) {
        print "mkdir $dir\n";
        mkpath $dir;
    }
    print "create file $file\n";
    open my $fh, ">", $file;
    print $fh $data;
    close $fh;
}

1;
__END__

=head1 NAME

WAFLWAFL - CRUD Template generator

=head1 SEE ALSO

wafl.pl / wafl-simple.pl

=head1 AUTHOR

torii, E<lt>torii@mshome.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by torii

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
