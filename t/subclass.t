#!/usr/bin/env perl
use warnings;
use strict;
use Test::More;
package Music::MyNote;
use parent 'Music::Note';
use Role::Tiny::With;
with 'Music::Note::Role::Operators';

package main;
my $note = Music::MyNote->new('C');
my $other = $note->clone;
ok $note->eq($other), "check class inherited ok";
ok $note == $other, "check same with overloading";
done_testing;
