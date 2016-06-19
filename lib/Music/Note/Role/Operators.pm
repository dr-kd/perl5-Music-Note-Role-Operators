package Music::Note::Role::Operators;

# ABSTRACT: Adds operator overloading and clone to Music::Note

use Role::Tiny;
use Storable qw/dclone/;
use overload
    '>'  => \&gt,
    '<'  => \&lt,
    '==' => \&eq,
    '>=' => \&gte,
    '<=' => \&lte,
    fallback => 1,
    ;

=head1 NAME

Music::Note::Role::Operators

=head2 DESCRIPTION

L<Role::Tiny> to be applied on top L<Music::Note> with comparison methods
added and overloaded operators.  Also adds a clone method.

=head2 SYNOPSIS

If you're working with a L<Music::Note> subclass:

    package Music::MyNote;
    use parent 'Music::Note';
    use Role::Tiny::With;
    with 'Music::Note::Role::Operators';
    # etc

Or if you're working in a script and just want the behaviour:

    use Music::Note;
    use Role::Tiny;
    Role::Tiny->apply_roles_to_package('Music::Note', 'Music::Note::Role::Operators');

=head2 SUMMARY

Assuming you're working in a script:

    my $note = Music::Note->new('C#');
    my $other = Music::Note->new('E');

    my $true = $other->gt($note);
    $true = $other > $note;

    $true = $note->lt($other);
    $true = $note < $other;

    $true = $note->eq($note->clone);
    $true = $note == $note->clone;

    $true = $note->gte($note->clone);
    $true = $note >= $note->clone;

    $true = $note->lte($note->clone);
    $true = $note <= $note->clone;

=head3 AUTHOR

Kieren Diment L<zarquon@cpan.org>

=head3 LICENSE

This code can be redistributed on the same terms as perl itself

=cut

sub gt {
    my ($self, $other) = @_;
    return $self->format('midinum') > $other->format('midinum');
}

sub lt {
    my ($self, $other) = @_;
    return $self->format('midinum') < $other->format('midinum');
}

sub eq {
    my ($self, $other) = @_;
    return $self->format('midinum') == $other->format('midinum');
}

sub gte {
    my ($self, $other) = @_;
    return $self->format('midinum') >= $other->format('midinum');
}

sub lte {
    my ($self, $other) = @_;
    return $self->format('midinum') <= $other->format('midinum');
}

sub clone {
    return $_[0]->dclone;
}

1;
