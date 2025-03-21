# bed2bam.sh 
#
# Script converts BAM file into a BED file and filters it using regex. 
# Input: 		BAM file
#			output directory
# Output:		BED file (converted from BAM file)
#			filtered BED file containing only regions from chromosome 1
#			txt file with the number of lines in the bedfile


# Set path
PATH=~:$PATH

# define inputs
input_bam=$1
output_dir=$2

# create output directory
mkdir -p $output_dir

# create and activate condo environment 
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
conda create -n bam2bed -y bedtools
conda activate bam2bed

# extract name of input BAM file
name_file=$(basename $input_bam)
name_file_no_extension="${name_file%.*}"

# convert input BAM file to output BED file
output_bed="$output_dir/${name_file_no_extension}" # set the output direction and name
bedtools bamtobed -i $input_bam > $output_bed.bed # > makes it so the bedfile is created inside the directory

# create filtered BED file containing only regions from chromosome 1 using regex
grep -E -i "^chr1\s" $output_bed.bed > ${output_bed}_chr1.bed # filter using grep
echo -n20 ${output_bed}_chr1.bed #

# counts number  of lines in the bedfile
wc -l ${output_bed}_chr1.bed > $output_dir/bam2bed_number_of_rows.txt
cat $output_dir/bam2bed_number_of_rows.txt

# Print my name in the terminal
echo Chen Chen
