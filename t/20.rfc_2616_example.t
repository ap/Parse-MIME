#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Parse::MIME qw( quality );
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

plan tests => 0 + keys %{ $testcase->{testcases} };

my $accept = $testcase->{ accept };
while ( my ( $type, $quality ) = each %{ $testcase->{testcases} } ) {
	is quality( $type, $accept ), $quality, $type;
}
