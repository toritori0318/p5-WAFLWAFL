use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample',
    'ORM' => {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    },
    'SRC' => File::Spec->catfile('eg', 'templates-mojolicious'),
    'WAF' => {
        Dispatcher => {
            file => File::Spec->catfile('lib', "$app.pm.dispatcher"),
        },
        Controller => {
            dir => File::Spec->catfile('lib', $app),
        },
        View => {
            dir => "templates",
            ext => ".html.ep",
        },
    },
};

