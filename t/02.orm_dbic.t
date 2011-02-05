use strict;
use warnings;

use Test::More;
use WAFLWAFL::ORM;
use lib 't/lib';

my $expected = {
    'Emp' => {
        pk    => 'empno',
        cols  => [qw/empno ename job mgr hiredate sal comm deptno/],
    },
    'Dept' => {
        pk    => 'deptno',
        cols  => [qw/deptno dname loc/],
    },
};

my $orm = WAFLWAFL::ORM->new(
    {
        module       => 'DBIC',
        schema_class => 'DBIC::Sample::Schema',
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
