package WAFLWAFL;

use strict;
use warnings;

our $VERSION = '0.01';
use 5.008001;

use WAFLWAFL::ORM;

use Class::Accessor::Lite new => 1, rw => [ qw(conf waf)] ;
use String::CamelCase qw(camelize);
use File::Spec;
use File::Path qw/mkpath/;
use File::Basename qw/dirname/;
use Text::Xslate;
use UNIVERSAL::require;
use Class::Inspector;
use File::Copy::Recursive qw(rcopy);

sub get {
    my ($class) = @_;
    my $waf = $class->waf;

    my $from_dir = File::Spec->catfile($class->_srcdir(), 'example-templates' ,$waf);
    my $to_dir = './wafl-template';
    rcopy($from_dir, $to_dir) or die "Can not copy `$from_dir` to `$to_dir`.";
    print "get template to $to_dir\n";
}

sub run {
    my ($class) = @_;
    my $config = $class->conf;

    my %prm;
    $prm{app}    = $config->{APP}    || "MyApp";
    $prm{output} = $config->{OUTPUT} || "crudsample";
    if($config->{SRC_EXAMPLE}) {
        $prm{src} = File::Spec->catfile($class->_srcdir(), 'example-templates' ,$config->{SRC_EXAMPLE});
    } elsif ($config->{SRC}) {
        $prm{src} = $config->{SRC};
    } else {
        die "require config value [SRC_EXAMPLE] or [SRC]";
    }
    unless($config->{WAF}) {
        die "require config value [WAF]";
    }

    my $module = 'WAFLWAFL::WAF::';
    for my $key (keys %{$config->{WAF}}){
        my $wafl_module = $module . $key;
        $wafl_module->require or die $@;
        $prm{cv} = $config->{WAF}->{$key};
        $class->proc($wafl_module->new(\%prm));
    }
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
                        ext      => $waf->{output_ext},
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
                        ext      => $waf->{output_ext},
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

sub _srcdir {
    my ($class) = @_;
    my $dir = Class::Inspector->resolved_filename(__PACKAGE__);
    $dir =~ s/.pm$//;
    return $dir;
}

1;
__END__

=head1 NAME

WAFLWAFL - CRUD Template generator

=head1 SYNOPSIS

SEE ALSO
 wafl / wafl-simple

=head1 AUTHOR

torii, E<lt>torii@mshome.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by torii

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
