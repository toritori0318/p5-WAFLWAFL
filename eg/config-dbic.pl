use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample',
    'ORM' => {
        module       => 'DBIC',
        schema_class => 'DBIC::Sample::Schema',
    },
    'TMPL' => {
        src => File::Spec->catfile('eg', 'templates-amon'),
        dispatcher => {
            file => File::Spec->catfile('lib', $app, 'Web', "Dispatcher.pm.sample"),
        },
        controller => {
            dir => File::Spec->catfile('lib', $app),
        },
        view => {
            dir => "tmpl",
            ext => ".tt",
        },
    },
};

