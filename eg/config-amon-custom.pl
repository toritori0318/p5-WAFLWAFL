use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample-amon',
    'ORM' => {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    },
    'SRC' => File::Spec->catfile('eg', 'templates-amon'),
    'WAF' => {
        Dispatcher => {
            file => File::Spec->catfile('lib', $app, 'Web', "Dispatcher.pm.sample"),
        },
        Controller => {
            dir => File::Spec->catfile('lib', $app, 'Web', 'C'),
        },
        View => {
            dir => "tmpl",
            ext => ".tt",
        },
    },
};

