use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name        => 'Parse::MIME',
	license            => 'perl',
	dist_author        => 'Aristotle Pagaltzis <pagaltzis@gmx.de>',
	requires           => {},
	build_requires     => { 'Test::More' => 0 },
	add_to_cleanup     => [ 'Parse-MIME-*' ],
	create_makefile_pl => 'traditional',
);

$builder->create_build_script();
