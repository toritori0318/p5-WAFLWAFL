+{
    module  => 'Skinny',
    class   => 'Skinny::Sample::DB',
    #tmpl    => '<: $column :>,',
    #tmpl    => '<: $column :>=?,'."\n",
    #tmpl    => '<: $column :>=? and' . "\n",
    #tmpl    => 'my $<: $column :> = shift;' . "\n",
    #tmpl    => '<: $column :> => $c->req->param("<: $column :>"),' . "\n",
#    tmpl    => q|
#sub <: $column :> {
#    my $self = shift;
#    if(@_) {
#        $self->{<: $column :>} = $_[0];
#    }
#    return $self->{<: $column :>};
#}
#|,
};

