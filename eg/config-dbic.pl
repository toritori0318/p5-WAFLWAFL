use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample-dbic',
    'ORM' => {
        module       => 'DBIC',
        schema_class => 'DBIC::Sample::Schema',
    },
    'SRC' => File::Spec->catfile('eg', 'templates-amon'),
    'WAF' => {
        Dispatcher => {
            file => File::Spec->catfile('lib', $app, 'Web', "Dispatcher.pm.sample"),
        },
        Controller => {
            dir => File::Spec->catfile('lib', $app),
        },
        View => {
            dir => "tmpl",
            ext => ".tt",
        },
    },
};

