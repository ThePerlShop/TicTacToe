package TicTacToe::Schema::ResultSet;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

__PACKAGE__->load_components(qw/
  Helper::ResultSet::Shortcut
  Helper::ResultSet::Me
  Helper::ResultSet::SetOperations
  Helper::ResultSet::IgnoreWantarray
/);

sub TO_JSON {
  my $self = shift;
  $self = $self->page(1) unless($self->is_paged);

  return +{
    pager => {
      total_entries => $self->pager->total_entries,
      current_page => $self->pager->current_page,
      next_page => $self->pager->next_page,
      entries_per_page => $self->pager->entries_per_page,
      last_page => $self->pager->last_page,
      ($self->pager->previous_page ?
        ( previous_page => $self->pager->previous_page) :
          ()),
    },
    results => [$self->hri->all]
  }; 
}

1;

=head1 NAME

TicTacToe::Schema::ResultSet - Base ResultSet Class

=head1 SYNOPSIS

    TBD

=head1 DESCRIPTION

All ResultSet classes inherit behavior from this

=head1 METHODS

This class defines the following methods

=head2 TO_JSON

Default data for generating JSON views

=head1 AUTHORS & COPYRIGHT

See L<TicTacToe>.

=head1 LICENSE

See L<TicTacToe>.

=cut
