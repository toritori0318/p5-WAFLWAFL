package DBIC::Sample::Schema::Result::Emp;
use strict;
use warnings;
use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("emp");

__PACKAGE__->add_columns(
  "empno",
  { data_type => "integer", is_nullable => 0 },
  "ename",
  { data_type => "text", is_nullable => 1 },
  "job",
  { data_type => "text", is_nullable => 1 },
  "mgr",
  { data_type => "integer", is_nullable => 1 },
  "hiredate",
  { data_type => "datetime", is_nullable => 1 },
  "sal",
  { data_type => "integer", is_nullable => 1 },
  "comm",
  { data_type => "integer", is_nullable => 1 },
  "deptno",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("empno");

# You can replace this text with custom content, and it will be preserved on regeneration
1;

