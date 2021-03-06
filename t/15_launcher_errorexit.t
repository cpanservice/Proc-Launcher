#!/perl
use strict;

use Proc::Launcher;

use File::Temp qw/ :POSIX /;
use Test::More tests => 3;


my ($fh, $file) = tmpnam();
close $fh;
unlink $file;

my $start_method = sub { exit 1 };

my $launcher = Proc::Launcher->new( start_method => $start_method,
                                        daemon_name  => 'test',
                                        pid_file     => $file,
                                    );

ok( ! $launcher->is_running(),
    "Checking that test process is not already running"
);

ok( $launcher->start(),
    "Starting the test process"
);

sleep 2;

ok( ! $launcher->is_running(),
    "Checking that process already exited"
);

