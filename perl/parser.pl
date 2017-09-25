#!/usr/bin/perl

my $filename = $ARGV[0];

# read translation text file
my $file = $filename; #"../translations/NIV.txt"; #"$ARGV[1];
my $document = do {
    local $/ = undef;
    open my $fh, "<", $filename
        or die "could not open $filename: $!";
    <$fh>;
};

$numSentences = 0;
$numWords = 0;
$numSyllables = 0;

# count occurances of each sentence end punctuation
my $periods = () = ($document =~ /\./g);
my $colons = () = ($document =~ /:/g);
my $semicolons = () = ($document =~ /;/g);
my $questions = () = ($document =~ /\?/g);
my $exclamations = () = ($document =~ /!/g);

$numSentences = $periods + $colons + $semicolons + $questions + $exclamations;


# split string with entire translation into individual word array
my @wordArray = split ' ', $document;

$prevVowel = 0;

foreach my $n (@wordArray){

    if(! ($n =~ /^\d+?$/)){

        # increment word count
        $numWords = 1 + $numWords;

        # remove punctuation from word
        $n =~ s/[[:punct:]]//g;

        # set word to lower case
        $n = lc $n;

        #print "$n\n";

        my @chars = split("", $n);
        $wordSyllables = 0;
        $prevVowel = 0;

        #count syllables in each word
        foreach my $c (@chars){
            if($c eq 'a' || $c eq 'e' || $c eq 'i' || $c eq 'o' || $c eq 'u' || $c eq 'y'){
                if($prevVowel == 0){
                    $wordSyllables = $wordSyllables + 1;              
                }  
                $prevVowel = 1;
            } 
            else{
                $prevVowel = 0;
            }
        }

        #handle silent e
        if($chars[@chars-1] eq 'e'){
            if($wordSyllables > 1){
                $wordSyllables = $wordSyllables - 1;
            }
        }

        $numSyllables = $numSyllables + $wordSyllables;
    }
}

#print "$numWords\n";
#print "$numSyllables\n";
#print "$numSentences\n";

# calculate and output Flesch Indeces

$alpha = $numSyllables/$numWords;
$beta = $numWords/$numSentences; 

my $fleschIndex = 206.835 - $alpha*84.6 - $beta*1.015;
my $fleschKincaidIndex = $alpha*11.8 + $beta*0.39 - 15.59;

print "Flesch Readability Index: $fleschIndex\n";
print "Flesch-Kincaid Grade Level Index: $fleschKincaidIndex\n";

