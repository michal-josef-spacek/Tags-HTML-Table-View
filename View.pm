package Tags::HTML::Table::View;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use List::MoreUtils qw(none);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['css_table', 'header'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# Main CSS class.
	$self->{'css_table'} = 'table';

	# Header is in first line.
	$self->{'header'} = 1;

	# Process params.
	set_params($self, @{$object_params_ar});

	# Object.
	return $self;
}

# Process 'Tags'.
sub _process {
	my ($self, $data_ar) = @_;

	# Main content.
	$self->{'tags'}->put(
		['b', 'table'],
		['a', 'class', $self->{'css_table'}],
	);
	if ($self->{'header'}) {
		$self->{'tags'}->put(
			['b', 'tr'],
		);
		my $header_ar = shift @{$data_ar};
		foreach my $value (@{$header_ar}) {
			$self->{'tags'}->put(
				['b', 'th'],
				['d', $value],
				['e', 'th'],
			);
		}
		$self->{'tags'}->put(
			['e', 'tr'],
		);
	}
	foreach my $row_ar (@{$data_ar}) {
		$self->{'tags'}->put(
			['b', 'tr'],
		);
		foreach my $value (@{$row_ar}) {
			$self->{'tags'}->put(
				['b', 'td'],
				['d', $value],
				['e', 'td'],
			);
		}
		$self->{'tags'}->put(
			['e', 'tr'],
		);
	}

	$self->{'tags'}->put(
		['e', 'table'],
	);

	return;
}

# Process 'CSS::Struct'.
sub _process_css {
	my $self = shift;

	$self->{'css'}->put(
		['s', '.'.$self->{'css_table'}.' table'],
		['s', '.'.$self->{'css_table'}.' th'],
		['s', '.'.$self->{'css_table'}.' td'],
		['d', 'border', '1px solid black'],
		['e'],
	);

	return;
}


1;

__END__

=pod

=encoding utf8

=head1 NAME

Tags::HTML::Table::View - Tags helper for table view.

=head1 SYNOPSIS

 use Tags::HTML::Table::View;

 my $obj = Tags::HTML::Table::View->new(%params);
 $obj->process;
 $obj->process_css;

=head1 METHODS

=head2 C<new>

 my $obj = Tags::HTML::Table::View->new(%params);

Constructor.

Returns instance of object.

=over 8

=item * C<css>

'CSS::Struct::Output' object for L<process_css> processing.

Default value is undef.

=item * C<css_table>

CSS class for table.

Default value is 'table'.

=item * C<header>

Boolean flag, that means that header is in first line.

Default value is 1.

=item * C<tags>

'Tags::Output' object.

Default value is undef.

=back

=head2 C<process>

 $obj->process($percent_value);

Process Tags structure for gradient.

Returns undef.

=head2 C<process_css>

 $obj->process_css;

Process CSS::Struct structure for output.

Returns undef.

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.
         From Tags::HTML::new():
                 Parameter 'css' must be a 'CSS::Struct::Output::*' class.
                 Parameter 'tags' must be a 'Tags::Output::*' class.

 process():
         From Tags::HTML::process():
                 Parameter 'tags' isn't defined.

 process_css():
         From Tags::HTML::process_css():
                 Parameter 'css' isn't defined.

=head1 EXAMPLE

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
 # CSS
 # .table table, .table th, .table td {
 #         border: 1px solid black;
 # }
 # 
 # HTML
 # <body>
 #   <table class="table">
 #     <tr>
 #       <th>
 #         Country
 #       </th>
 #       <th>
 #         Capital
 #       </th>
 #     </tr>
 #     <tr>
 #       <td>
 #         Czech Republic
 #       </td>
 #       <td>
 #         Prague
 #       </td>
 #     </tr>
 #     <tr>
 #       <td>
 #         Russia
 #       </td>
 #       <td>
 #         Moscow
 #       </td>
 #     </tr>
 #   </table>
 # </body>

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<List::MoreUtils>,
L<Tags::HTML>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Tags-HTML-Table-View>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© Michal Josef Špaček 2021-2022

BSD 2-Clause License

=head1 VERSION

0.01

=cut
