use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample-catalyst',
    'ORM' => {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    },
    'TMPL' => {
        src => File::Spec->catfile('eg', 'templates-catalyst'),
        controller => {
            dir => File::Spec->catfile('lib', $app, 'Web', 'Controller'),
        },
        view => {
            dir => "root",
            ext => ".tt",
        },
    },
};

