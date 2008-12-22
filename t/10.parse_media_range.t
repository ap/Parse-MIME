#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( parse_media_range );

my %testcase = (
	'application/xml;q=1'           => [ 'application', 'xml', { q => 1 } ],
	'application/xml'               => [ 'application', 'xml', { q => 1 } ],
	'application/xml;q='            => [ 'application', 'xml', { q => 1 } ],
	'application/xml ; q='          => [ 'application', 'xml', { q => 1 } ],
	'application/xml ; q=1;b=other' => [ 'application', 'xml', { q => 1, b => 'other' } ],
	'application/xml ; q=2;b=other' => [ 'application', 'xml', { q => 1, b => 'other' } ],

	# Java URLConnection class sends an Accept header that includes a single *
	' *; q=.2' => [ '*', '*', { q => '.2' } ],
);

plan tests => 0 + keys %testcase;

while ( my ( $range, $parsed ) = each %testcase ) {
	is_deeply [ parse_media_range $range ], $parsed, $range;
}
