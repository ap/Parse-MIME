#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( best_match );
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

use constant { RANGE => 0, RESULT => 1, DESC => 2 };

use List::Util 'sum';
plan tests => 0 + sum map { 0 + @{ $_->{testcases} } } @$testcase;

for my $group ( @$testcase ) {
	my $mime_types_supported = $group->{ supported };

	for my $case ( @{ $group->{ testcases } } ) {
		is best_match( $mime_types_supported, $case->[ RANGE ] ), $case->[ RESULT ], $case->[ DESC ];
	}
}
