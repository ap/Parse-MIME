#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( quality );

my $accept = 'text/*;q=0.3, text/html;q=0.7, text/html;level=1, text/html;level=2;q=0.4, */*;q=0.5';
my %testcase = (
	'text/html;level=1' => 1.0,
	'text/html'         => 0.7,
	'text/plain'        => 0.3,
	'image/jpeg'        => 0.5,
	'text/html;level=2' => 0.4,
	'text/html;level=3' => 0.7,
);

plan tests => 0 + keys %testcase;

while ( my ( $type, $quality ) = each %testcase ) {
	is quality( $type, $accept ), $quality, $type;
}
