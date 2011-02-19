use strict;
use warnings;

use Test::More;
use Test::Requires qw/DBIx::Class/;
use WAFLWAFL::Simple qw/proc/;
use lib 't/lib';

my $config = {
    module => 'DBIC',
    class  => 'DBIC::Sample::Schema',
    table  => 'Emp',
    tmpl   => '<: $column :>,',
};

{
    my $output;
    open my $OUT, '>', \$output;
    local *STDOUT = *$OUT;
    proc(
        $config->{module},
        $config->{class},
        $config->{table},
        $config->{tmpl},
    );
    close($OUT);
    like ( $output, qr/empno,ename,job,mgr,hiredate,sal,comm,deptno,/ );
}

done_testing;
