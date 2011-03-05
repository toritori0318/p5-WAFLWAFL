use inc::Module::Install;

# Define metadata
all_from 'lib/WAFLWAFL.pm';

# Specific dependencies
requires 'Class::Accessor::Lite';
requires 'String::CamelCase';
requires 'File::Spec';
requires 'File::Path';
requires 'Text::Xslate';
requires 'UNIVERSAL::require';
requires 'File::Path';
requires 'File::Copy::Recursive';

requires 'Getopt::Compact::WithCmd';


install_script 'script/wafl';
install_script 'script/wafl-simple';

WriteAll;
