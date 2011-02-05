use strict;
use warnings;

use Test::More;
BEGIN { 
    use_ok('WAFLWAFL');
    use_ok('WAFLWAFL::ORM');
    use_ok('WAFLWAFL::ORM::Skinny');
    use_ok('WAFLWAFL::WAF');
    use_ok('WAFLWAFL::WAF::Controller');
    use_ok('WAFLWAFL::WAF::Dispatcher');
    use_ok('WAFLWAFL::WAF::View');
};

done_testing;
