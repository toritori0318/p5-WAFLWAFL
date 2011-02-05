use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample',
    'ORM' => {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    },
    'TMPL' => {
        src => File::Spec->catfile('eg', 'templates-amon'),
        dispatcher => {
            file => File::Spec->catfile('lib', $app, 'Web', "Dispatcher.pm.sample"),
        },
        controller => {
            dir => File::Spec->catfile('lib', $app, 'Web', 'C'),
        },
        view => {
            dir => "tmpl",
            ext => ".tt",
        },
    },
};

