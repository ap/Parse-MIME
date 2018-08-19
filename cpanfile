requires 'perl', '5.006';
requires 'Exporter';

on test => sub {
	requires 'JSON::PP';
	requires 'Test::More';
};

# vim: ft=perl
