#!/usr/bin/perl
use warnings;
use strict;

# Διαβάζουμε το αρχείο FASTA
open(INPUT, "<", "MA0035.4.sites.fasta") or die "Δεν μπορώ να ανοίξω το αρχείο: $!\n";

my @sequences;
my $sequence = "";

while (my $line = <INPUT>) {
    chomp $line;
    if ($line =~ /^>/) {
        if ($sequence ne "") {
            push @sequences, $sequence;
            $sequence = "";
        }
    } else {
        $sequence .= uc($line);  # μετατρέπουμε σε κεφαλαία
    }
}
push @sequences, $sequence if $sequence ne "";
close(INPUT);

# Έλεγχος ίδιου μήκους
my $length = length($sequences[0]);
foreach my $seq (@sequences) {
    if (length($seq) != $length) {
        die "Οι ακολουθίες δεν έχουν το ίδιο μήκος.\n";
    }
}

# Αρχικοποίηση PFM
my %PFM = (
    "A" => [(0) x $length],
    "C" => [(0) x $length],
    "G" => [(0) x $length],
    "T" => [(0) x $length],
);

# Συμπλήρωση PFM
foreach my $seq (@sequences) {
    for (my $i = 0; $i < $length; $i++) {
        my $base = substr($seq, $i, 1);
        if (exists $PFM{$base}) {
            $PFM{$base}[$i]++;
        }
    }
}

# Γράφουμε το PFM σε αρχείο
open(OUT, ">", "PFM2.txt") or die "Δεν μπορώ να γράψω το αρχείο: $!\n";
print OUT "A\t" . join("\t", @{$PFM{"A"}}) . "\n";
print OUT "C\t" . join("\t", @{$PFM{"C"}}) . "\n";
print OUT "G\t" . join("\t", @{$PFM{"G"}}) . "\n";
print OUT "T\t" . join("\t", @{$PFM{"T"}}) . "\n";
close(OUT);

print "Ο πίνακας PFM γράφτηκε στο αρχείο PFM.txt\n";
