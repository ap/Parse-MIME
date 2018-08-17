requires 'perl', '5.006';
requires 'strict';
requires 'warnings';
requires 'Exporter';

on test => sub {
	requires 'File::Basename';
	requires 'JSON::PP';
	requires 'List::Util';
	requires 'Test::More';
	requires 'constant';
	requires 'lib';
};

# vim: ft=perl
