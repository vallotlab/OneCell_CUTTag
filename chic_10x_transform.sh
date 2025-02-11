#!/bin/bash

## If a script throws a gzip: stdout: Broken pipe error, increase RAM

# Input and output files
r1_file="SCC-scChIC-CUR-PER-001_AACGFYKM5_S8_L001_R1_001.fastq.gz"
r2_file="SCC-scChIC-CUR-PER-001_AACGFYKM5_S8_L001_R2_001.fastq.gz"
barcode_file="maya_384NLA.bc"
barcode_output="chic_R2.fastq"
rest_output="chic_R1.fastq"
r2_output="chic_R3.fastq"

# Build a set of valid barcodes (using grep to ensure no empty lines)
valid_barcodes=$(awk '{print substr($2, 1, 8)}' "$barcode_file" | grep -v '^$' | paste -sd'|' -)

# Debug: Print the generated regex pattern for validation
echo "Valid barcodes regex: ^($valid_barcodes)$"

# Temporary files
temp_r1_filtered="temp_r1_filtered.fastq"

# Extract barcode sequences, remaining sequences, and split quality scores in R1
zcat "$r1_file" | awk -v regex="^($valid_barcodes)$" '
  NR % 4 == 1 { 
    header = $0 
    header_barcode = header   # Create a modified header for the barcode file
    sub(/ 1:N:/, " 2:N:", header_barcode)  # Replace " 1:N:" with " 2:N:"
  }
  NR % 4 == 2 {                 # Sequence line
    barcode = substr($0, 4, 8)   # Extract barcode (bases 4-11)
    rest = substr($0, 12)        # Extract rest of the sequence (after base 11)
  }
  NR % 4 == 0 {                 # Quality score line
    quality = $0                 # Get the quality line
    barcode_quality = substr(quality, 4, 8)  # Extract quality corresponding to the barcode
    rest_quality = substr(quality, 12)       # Extract quality for the rest of the sequence
    if (barcode ~ regex) {                   # Check if the barcode matches valid barcodes
      # Write to temp filtered R1
      print header >> "'"$temp_r1_filtered"'"
      print barcode >> "'"$temp_r1_filtered"'"
      print "+" >> "'"$temp_r1_filtered"'"
      print barcode_quality >> "'"$temp_r1_filtered"'"

      # Write modified header to barcode_output
      print header_barcode >> "'"$barcode_output"'"
      print barcode >> "'"$barcode_output"'"
      print "+" >> "'"$barcode_output"'"
      print barcode_quality >> "'"$barcode_output"'"

      # Write the rest of the sequence to rest_output
      print header >> "'"$rest_output"'"
      print rest >> "'"$rest_output"'"
      print "+" >> "'"$rest_output"'"
      print rest_quality >> "'"$rest_output"'"
    }
  }
'

# Extract the headers of filtered R1 reads for use in R2 filtering
awk 'NR % 4 == 1 { sub(/ 1:/, " 2:"); print $0 }' "$temp_r1_filtered" > filtered_headers.txt

# Filter R2 based on R1 barcodes
r2_output_tmp="r2_output_tmp.fastq"

zcat "$r2_file" | awk '
  BEGIN { 
    while ((getline line < "filtered_headers.txt") > 0) 
      r1_headers[line] = 1 
  }
  NR % 4 == 1 { header = $0 }
  NR % 4 == 2 { sequence = $0 }
  NR % 4 == 3 { plus_line = $0 }
  NR % 4 == 0 { 
    quality = $0
    if (header in r1_headers) {
      # Write the header, sequence, plus sign, and quality to the R2 output
      print header >> "'"$r2_output_tmp"'"
      print sequence >> "'"$r2_output_tmp"'"
      print plus_line >> "'"$r2_output_tmp"'"
      print quality >> "'"$r2_output_tmp"'"
    }
  }
'

# Rename headers in r2_output_tmp to replace " 2:N:" with " 3:N:"
cat "$r2_output_tmp" | awk '
  NR % 4 == 1 { 
    header = $0 
    header_new = header   # Create a modified header 
    sub(/ 2:N:/, " 3:N:", header_new)  # Replace " 2:N:" with " 3:N:"
  }
  NR % 4 == 2 { sequence = $0 }
  NR % 4 == 3 { plus_line = $0 }
  NR % 4 == 0 { quality = $0 
      print header_new >> "'"$r2_output"'"
      print sequence >> "'"$r2_output"'"
      print plus_line >> "'"$r2_output"'"
      print quality >> "'"$r2_output"'"
  }
'

# Clean up temporary files
rm "$temp_r1_filtered" "$r2_output_tmp" filtered_headers.txt

# Compress output files 
gzip "$barcode_output"
gzip "$rest_output"
gzip "$r2_output"
