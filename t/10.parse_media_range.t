#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( parse_media_range );
use File::Basename qw( fileparse );
use JSON::XS;

my $testcase = decode_json do {

	my ( $name, $path ) = fileparse( $0, qr/\.t\z/ );
	my $testfile = "$path$name.json";

	open my $fh, '<', $testfile
		or die "can't open $testfile for reading: $!\n";

	local $/;
	<$fh>;

};

plan tests => 0 + keys %$testcase;

while ( my ( $range, $parsed ) = each %$testcase ) {
	is_deeply [ parse_media_range $range ], $parsed, $range;
}
