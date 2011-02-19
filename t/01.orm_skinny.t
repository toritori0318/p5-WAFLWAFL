use strict;
use warnings;

use Test::More;
use Test::Requires qw/DBIx::Skinny/;
use WAFLWAFL::ORM;
use lib 't/lib';

my $expected = {
    'emp' => {
        pk    => 'empno',
        cols  => [qw/empno ename job mgr hiredate sal comm deptno/],
    },
    'dept' => {
        pk    => 'deptno',
        cols  => [qw/deptno dname loc/],
    },
};

my $orm = WAFLWAFL::ORM->new(
    {
        module       => 'Skinny',
        schema_class => 'Skinny::Sample::DB',
    }
);
my @schemas = $orm->schemas;
for my $table (@schemas) {
    my $pk   = $orm->pk($table);
    my $cols = $orm->columns($table);
    is($pk, $expected->{$table}->{pk});
    is_deeply($cols, $expected->{$table}->{cols});
}

done_testing;
