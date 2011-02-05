package Skinny::Sample::DB::Schema;
use DBIx::Skinny::Schema;

########################################
# schema

install_table emp => schema {
    pk qw/empno/;
    columns qw/empno ename job mgr hiredate sal comm deptno/;
};

install_table dept => schema {
    pk qw/deptno/;
    columns qw/deptno dname loc/;
};

1;



