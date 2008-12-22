#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( best_match );

use constant { RANGE => 0, RESULT => 1, DESC => 2 };

my @test_group = (
	{
		supported => [ qw( application/xbel+xml application/xml ) ],
		testcases => [
			[ 'application/xbel+xml',      'application/xbel+xml', 'direct match' ],
			[ 'application/xbel+xml; q=1', 'application/xbel+xml', 'direct match with a q parameter' ],
			[ 'application/xml; q=1',      'application/xml',      'direct match of our second choice with a q parameter' ],
			[ 'application/*; q=1',        'application/xml',      'match using a subtype wildcard' ],
			[ '*/*',                       'application/xml',      'match using a type wildcard' ],
		],
	},
	{
		supported => [ qw( application/xbel+xml text/xml ) ],
		testcases => [
			[ 'text/*;q=0.5,*/*; q=0.1',               'text/xml', 'match using a type versus a lower weighted subtype' ],
			[ 'text/html,application/atom+xml; q=0.9', undef,      'fail to match anything' ],
		],
	},
	{
		supported => [ qw( application/json text/html ) ],
		testcases => [
			[ 'application/json, text/javascript, */*', 'application/json', 'common AJAX scenario' ],
			[ 'application/json, text/html;q=0.9',      'application/json', 'verify fitness ordering' ],
		],
	},
	{
		supported => [ qw( image/* application/xml ) ],
		testcases => [
			[ 'image/png', 'image/*', 'match using a type wildcard' ],
			[ 'image/*',   'image/*', 'match using a wildcard for both requested and supported ' ],
		],
	}
);

use List::Util 'sum';
plan tests => 0 + sum map { 0 + @{ $_->{testcases} } } @test_group;

for my $group ( @test_group ) {
	my $mime_types_supported = $group->{ supported };

	for my $case ( @{ $group->{ testcases } } ) {
		is best_match( $mime_types_supported, $case->[ RANGE ] ), $case->[ RESULT ], $case->[ DESC ];
	}
}
