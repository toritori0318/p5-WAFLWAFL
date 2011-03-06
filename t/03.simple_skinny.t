use strict;
use warnings;

use Test::More;
use Test::Requires qw/DBIx::Skinny/;
use WAFLWAFL::Simple qw/proc/;
use lib 't/lib';

my $config = {
    module => 'Skinny',
    class  => 'Skinny::Sample::DB',
    tmpl   => '<: $column :>,',
    table  => 'emp',
};

{
    my $output;
    open my $OUT, '>', \$output;
    local *STDOUT = *$OUT;
    proc(
        $config->{module},
        $config->{class},
        $config->{tmpl},
        $config->{table},
    );
    close($OUT);
    like ( $output, qr/empno,ename,job,mgr,hiredate,sal,comm,deptno,/ );
}

done_testing;
