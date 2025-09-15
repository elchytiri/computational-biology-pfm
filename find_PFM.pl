#!/usr/bin/perl
use strict;
use warnings;

my $input = 'ten_dna_sequences.fasta';
my $output = 'PFM.txt';

open(my $fh, '<', $input) or die "Δεν μπορώ να ανοίξω το αρχείο εισόδου!\n";
my @sequences;
my $seq = '';

while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ /^>/) {
        push @sequences, $seq if $seq ne '';
        $seq = '';
    } else {
        $seq .= $line;
    }
}
push @sequences, $seq if $seq ne '';
close($fh);

# Έλεγχος ίδιου μήκους
my $len = length($sequences[0]);
foreach my $s (@sequences) {
    die "Οι αλληλουχίες δεν έχουν το ίδιο μήκος!\n" 
    if length($s) != $len;
}

# Υπολογισμός PFM
my @PFM;
for my $i (0 .. $len - 1) {
    $PFM[$i] = { A => 0, C => 0, G => 0, T => 0 };
}

foreach my $s (@sequences) {
    for my $i (0 .. $len - 1) {
        my $base = substr($s, $i, 1);
        $PFM[$i]{$base}++ if exists $PFM[$i]{$base};
    }
}

# Συναινετική αλληλουχία & score
my $regex = '';
my $score = 0;

for my $i (0 .. $#PFM) {
    my %count = %{$PFM[$i]};
    my $max = 0;
    my @best;

    foreach my $b (qw(A C G T)) {
        if ($count{$b} > $max) {
            $max = $count{$b};
            @best = ($b);
        } elsif ($count{$b} == $max) {
            push @best, $b;
        }
    }
    $regex .= "[" . join('', sort @best) . "]";
    $score += $max;
}

# Εγγραφή στο PFM.txt
open(my $out, '>', $output) or die "Δεν μπορώ να γράψω στο αρχείο εξόδου!\n";
foreach my $b (qw(A C G T)) {
    print $out "$b ";
    for my $i (0 .. $#PFM) {
        print $out "$PFM[$i]{$b} ";
    }
    print $out "\n";
}
print $out "$regex\n";
print $out "Score=$score\n";
close($out);

print "Το αρχείο PFM.txt δημιουργήθηκε με επιτυχία.\n";
