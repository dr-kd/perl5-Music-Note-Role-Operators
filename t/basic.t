#!/usr/bin/env perl
use warnings;
use strict;
use Test::More;
use Role::Tiny ();
use Test::Exception;
use Music::Note;
Role::Tiny->apply_roles_to_package('Music::Note', 'Music::Note::Role::Operators');

my $note = Music::Note->new('C');
my $other = Music::Note->new('G');

# Some overload gotchas I found during workup
ok "$note", "Note stringifies according to default behaviour";
ok !!$note, "Note boolifies ok according to default behaviour";

# Implementation tests
ok $other->gt($note), "note greater than other";
ok $other > $note, "note greater than other overloaded";

ok $note->lt($other), "note less than other";
ok $note < $other, "note less than other overloaded";

my $same = $note->clone;
ok $note->lte($same), "note less than or equal to its clone";
ok $note <= $same, "note less than or equal to clone overloaded";
ok $note->gte($same), "note greater than or equal to its clone";

ok $note->eq($same), "note is same val as its clone";
ok $note == $same, "note is same value as its clone overloaded";

dies_ok { $note < 10 } "Overloading should only be done where both entities are a Music::Note";

done_testing;
