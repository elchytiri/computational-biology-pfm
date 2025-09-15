# computational-biology-pfm
"Perl scripts for computing Position Frequency Matrices (PFMs) and consensus sequences from DNA FASTA files (Computational Biology coursework)."
# Position Frequency Matrix (PFM) Tools

This repository contains two Perl scripts developed as part of the *Computational Biology* course (Spring 2025).  
The scripts compute Position Frequency Matrices (PFMs) and consensus sequences from DNA sequences in FASTA format.

## Files
- **find_PFM.pl**  
  Reads a FASTA file of DNA sequences (equal length) and produces:
  - Position Frequency Matrix (PFM)
  - Consensus sequence
  - Consensus sequence as a regular expression
  - Consensus score  
  Output: `PFM.txt`

- **find_PFM_2.pl**  
  Adapted version of the first script for the JASPAR motif **MA0035.4** dataset.  
  Handles both lowercase and uppercase input FASTA files.  
  Output: `PFM2.txt`

## Input Data
- `ten_dna_sequences.fasta` (provided in course materials)  
- `MA0035.4.sites.fasta` (downloaded from JASPAR database)

## Requirements
- Perl 5.x

## Example Usage
```bash
perl find_PFM.pl ten_dna_sequences.fasta > PFM.txt
perl find_PFM_2.pl MA0035.4.sites.fasta > PFM2.txt
