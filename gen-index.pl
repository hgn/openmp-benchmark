#!/usr/bin/perl


use strict; use warnings;

use locale;
use POSIX qw (locale_h);

setlocale(LC_ALL, "C" );


sub prt_content {

   opendir(CURRDIR, ".");

   foreach my $file (sort readdir CURRDIR) {

      # skip some _special_ files
      if ($file eq "gen-index.pl" or
          $file eq "index.html" or
          $file eq "." or
          $file eq ".gen-index.pl.swp") {
         next;
      }

      # print directories
      if (-d "./$file") {
         print "<a class=\"title\" href=\"$file\">[DIR] <b>$file</b> </a>\n";
         next;
      }

      # print normal files
      if ($file =~ /\.pdf/i) {
         print "<a class=\"title\" href=\"$file\">[PDF] <b>$file</b> </a>\n";
      } else {
         print "<a class=\"title\" href=\"$file\">[ASC] <b>$file</b> </a>\n";
      }
   }

   closedir(CURRDIR);

}

sub prt_head {

   my $username = `id -unr`;

   print <<EOF;
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<title>var</title>
<style type="text/css">
body {
	font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
	margin:10px; background-color:#ffffff; color:#000000;
}
a { color:#0000cc; }
a:hover, a:visited, a:active { color:#880000; }
div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
div.page_header a:visited, a.header { color:#0000cc; }
div.page_header a:hover { color:#880000; }
div.page_nav { padding:8px; }
div.page_nav a:visited { color:#0000cc; }
div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
div.page_footer { height:17px; margin-top:40px; padding:4px 8px; background-color: #d9d8d1; }
div.page_footer_text { float:left; color:#555555; font-style:italic; }
div.page_body { padding:8px; }
div.title, a.title {
	display:block; padding:6px 8px;
	background-color:#edece6;
   text-decoration:none;
   color:#000000;
}
a.title:hover { background-color: #d9d8d1; }
div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
a.list { text-decoration:none; color:#000000; }
a.list:hover { text-decoration:underline; color:#880000; }
a.text { text-decoration:none; color:#0000cc; }
a.text:visited { text-decoration:none; color:#880000; }
a.text:hover { text-decoration:underline; color:#880000; }
a.img { border:none; }
table { padding:8px 4px; }
th { padding:2px 5px; font-size:12px; text-align:left; }
tr.light:hover { background-color:#edece6; }
tr.dark { background-color:#f6f6f0; }
tr.dark:hover { background-color:#edece6; }
td { padding:2px 5px; font-size:12px; vertical-align:top; }
td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }

</style>
</head>
<body>
  <div class="title"><h1>Digital Unsorted Conglomeration - JAUU.NET</h1></div>
<table cellspacing="0">
<tr><td>Owner</td><td>$username</td></tr>
</table>
<div>
EOF
}

sub prt_foot {
   my $date = POSIX::strftime( "%c", localtime());;
   print <<EOF;
</div>
<div class="page_footer">
<div class="page_footer_text">
 $date
</div>
</div>
</body>
</html>
EOF

}


prt_head();
prt_content();
prt_foot();

