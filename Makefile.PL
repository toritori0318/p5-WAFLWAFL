use inc::Module::Install;

# Define metadata
name           'WAFLWAFL';
all_from       'lib/WAFLWAFL.pm';

# Specific dependencies
requires       'Class::Accessor::Lite';
requires       'String::CamelCase';
requires       'File::Spec';
requires       'File::Path';
requires       'Text::Xslate';
requires       'UNIVERSAL::require';
requires       'File::Path';

WriteAll;
