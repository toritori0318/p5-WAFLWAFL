package DBIC::Sample::Schema::Result::Dept;
use strict;
use warnings;
use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("dept");

__PACKAGE__->add_columns(
  "deptno",
  { data_type => "integer", is_nullable => 0 },
  "dname",
  { data_type => "text", is_nullable => 1 },
  "loc",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("deptno");

# You can replace this text with custom content, and it will be preserved on regeneration
1;

