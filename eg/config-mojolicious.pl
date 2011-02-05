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
        src => File::Spec->catfile('eg', 'templates-mojolicious'),
        dispatcher => {
            file => File::Spec->catfile('lib', "$app.pm.dispatcher"),
        },
        controller => {
            dir => File::Spec->catfile('lib', $app),
        },
        view => {
            dir => "templates",
            ext => ".html.ep",
        },
    },
};

