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
my $table_data_ar = [];

# Process login button.
$obj->process_css;
$tags->put(['b', 'body']);
$obj->process($table_data_ar, 'No data.');
$tags->put(['e', 'body']);

# Print out.
print "CSS\n";
print $css->flush."\n\n";
print "HTML\n";
print $tags->flush."\n";

# Output:
# CSS
# table, td, th {
#         border: 1px solid #ddd;
#         text-align: left;
# }
# table {
#         border-collapse: collapse;
#         width: 100%;
# }
# th, td {
#         padding: 15px;
# }
#
# HTML
# <body>
#   <table class="table">
#     <tr>
#     </tr>
#     <tr>
#       <td colspan="0">
#         No data.
#       </td>
#     </tr>
#   </table>
# </body>