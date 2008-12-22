use Test::More tests => 2;

BEGIN {
use_ok( 'Parse::MIME', ':all' )
or BAIL_OUT( 'testing pointless if the module won\'t even load' );
}

can_ok 'main', qw( parse_mime_type parse_media_range parse_media_range_list fitness_and_quality_parsed quality_parsed quality best_match );

diag( "Testing Parse::MIME $Parse::MIME::VERSION" );
