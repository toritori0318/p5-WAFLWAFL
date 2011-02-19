use File::Spec;
my $app = 'MyApp';
+{
    'APP'    => $app,
    'OUTPUT' => 'crudsample-catalyst',
    'ORM' => {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    },
    'SRC' => File::Spec->catfile('eg', 'templates-catalyst'),
    'WAF' => {
        Controller => {
            dir => File::Spec->catfile('lib', $app, 'Web', 'Controller'),
        },
        View => {
            dir => "root",
            ext => ".tt",
        },
    },
};

