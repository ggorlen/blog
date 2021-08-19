#!/usr/bin/env perl

use strict;
use warnings;
use File::Slurp;
use Text::Markdown "markdown";

my $blog_title = "blog";
my $content_dir = "content";
my $posts_dir = "posts";
my $layouts_dir = "layouts";
my $header = read_file("$layouts_dir/header.html");
my $footer = read_file("$layouts_dir/footer.html");

sub writef {
    my ($path, $content) = @_;
    open(FH, ">", $path) or die $!;
    print FH $content;
    close(FH);
}

opendir(DIR, $content_dir) or die "failed to open directory $!\n";
my @posts;

while (my $file = readdir(DIR)) {
    $file =~ /^(\d{4}-\d\d-\d\d).*\.md$/ or next;

    my $date = $1;

    my $post_header = "### $date [$blog_title](..)";
    my $text = read_file("$content_dir/$file");

    $file =~ s/\.md/.html/g;
    $text =~ /^# (.+)$/gm or die "title missing for post $file";
    my $title = $1;
    push @posts, "- $date: [$title]($posts_dir/$file)";

    next if -e "$posts_dir/$file";

    my $html = markdown($post_header) . markdown($text);
    writef("$posts_dir/$file", $header . $html . $footer);
}

closedir(DIR);
my $content = "<h1>$blog_title</h1>". markdown(join("\n", @posts));
writef("index.html", $header . $content . $footer);

