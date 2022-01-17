#!/usr/bin/env perl

use strict;
use warnings;

use CSS::Struct::Output::Indent;
use Tags::HTML::Table::View;
use Tags::Output::Indent;

# Object.
my $css = CSS::Struct::Output::Indent->new;
my $tags = Tags::Output::Indent->new;
my $obj = Tags::HTML::Table::View->new(
        'css' => $css,
        'tags' => $tags,
);

# Table data.
my $table_data_ar = [
        ['Country', 'Capital'],
        ['Czech Republic', 'Prague'],
        ['Russia', 'Moscow'],
];

# Process login button.
$obj->process_css;
$tags->put(['b', 'body']);
$obj->process($table_data_ar);
$tags->put(['e', 'body']);

# Print out.
print "CSS\n";
print $css->flush."\n\n";
print "HTML\n";
print $tags->flush."\n";

# Output:
# TODO