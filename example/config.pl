use File::Spec;
+{
    'OUTPUT' => 'crudsample',
    'ORM' => {
        module        => "Skinny",
        schema_class  => "Sample::DB",
    },
    'TMPL' => {
        src => File::Spec->catfile('example', 'sample-templates'),
        controller => File::Spec->catfile('lib', 'C'),
        view => "tmpl",
    },
};

