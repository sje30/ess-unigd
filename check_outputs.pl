#!/usr/bin/env perl

use File::Copy;
use File::stat;
$sequence = 1;
$delay = 1.0;
$curr_md5 = "missing";

#$port="59513"; $token="PiOUI6ZA";
#$url = "http://127.0.0.1:$port/plot?token=$token";
$url = "http://127.0.0.1:5900/plot";

# before the server is running we get an empty file; before first plot
# has been made we will return 404 Not Found so ignore these files by
# assuming anything under 20 bytes is not valid svg.


# create a dummy svg as a holding spot.

my $waiting = <<'ENDOFSVG';
<svg height="400" width="400">
  <text x="100" y="200" fill="teal" font-size="35">ESS rocks...</text>
</svg>
ENDOFSVG


$latest = "latest.svg";

open $file, ">", $latest or die $!;
print $file $waiting;
close $file;


while(1) {
    system("curl -s $url > o.svg");
    $md5 = `md5sum < o.svg`;
    $filesize = stat("o.svg")->size;
    print("svg is size $filesize\n");
    ## Only need to copy the image if the image has changed,
    ## i.e if the md5sum has changed.
    if ( ($filesize > 20) && !($md5 eq $curr_md5) ) {
	print("saving image $sequence ... \n");
	copy("o.svg", "image-$sequence.svg");
	copy("o.svg", $latest);
	$sequence++;
	$curr_md5 = $md5;
    }
    print("sleep...\n");
    sleep $delay;

}
	

