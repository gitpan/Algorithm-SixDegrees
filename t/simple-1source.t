use Test::More tests => 12;

BEGIN {
use_ok( 'Algorithm::SixDegrees' );
}

my $sd = new Algorithm::SixDegrees;
isa_ok($sd,'Algorithm::SixDegrees');

$sd->data_source( Simple => \&Simple );

is_deeply([$sd->make_link('Simple','one','zero')],[],'No match OK');
is($Algorithm::SixDegrees::ERROR,undef,'No error during make_link');
is_deeply([$sd->make_link('Simple','one','one')],['one'],'Single element link OK');
is($Algorithm::SixDegrees::ERROR,undef,'No error during make_link');
is_deeply([$sd->make_link('Simple','one','two')],['one','two'],'Double element link OK');
is($Algorithm::SixDegrees::ERROR,undef,'No error during make_link');
is_deeply([$sd->make_link('Simple','one','three')],['one','two','three'],'Triple element link OK');
is($Algorithm::SixDegrees::ERROR,undef,'No error during make_link');
is_deeply([$sd->make_link('Simple','one','nine')],['one','two','three','four','five','six','seven','eight','nine'],'9 element link OK');
is($Algorithm::SixDegrees::ERROR,undef,'No error during make_link');

exit(0);

sub Simple {
	my $element = shift;
	return qw/two/ if $element eq 'one';
	return qw/one three/ if $element eq 'two';
	return qw/two four/ if $element eq 'three';
	return qw/three five/ if $element eq 'four';
	return qw/four six/ if $element eq 'five';
	return qw/five seven/ if $element eq 'six';
	return qw/six eight/ if $element eq 'seven';
	return qw/seven nine/ if $element eq 'eight';
	return qw/eight/ if $element eq 'nine';
	return;
}
