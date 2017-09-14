#!/usr/bin/perl

foreach my $arg (@ARGV) {
    print $arg, "\n";
}

print $ARGV[0];

#my $translation = read_file( ARGV[1] );
my $filename = $ARGV[0];

print $filename

my $file = $filename; #"../translations/NIV.txt"; #"$ARGV[1];
my $document = do {
    local $/ = undef;
    open my $fh, "<", $filename
        or die "could not open $filename: $!";
    <$fh>;
};


#print $document;
$numSentences = 0;
$numWords = 0;
$numSyllables = 0;

my $periods = () = ($document =~ /\./g);
print "periods: $periods\n";

my $colons = () = ($document =~ /:/g);
print "colons: $colons\n";

my $semicolons = () = ($document =~ /;/g);
print "semicolons: $semicolons\n";

my $questions = () = ($document =~ /\?/g);
print "questions: $questions\n";

my $exclamations = () = ($document =~ /!/g);
print "exclamations: $exclamations\n";

$numSentences = $periods + $colons + $semicolons + $questions + $exclamations;

print "$numSentences\n";

$document =~ s/\d//g;

#print $document;

my @wordArray = split ' ', $document;

#print $wordArray;

$prevVowel = 0;

foreach my $n (@wordArray){
    $n =~ s/[[:punct:]]//g;
    $n = lc $n;
    #print "$n\n";
    my @chars = split("", $n);
    $wordSyllables = 0;
    $prevVowel = 0;
    foreach my $c (@chars){
        #print "$c\n";
        #print "prevVowel: $prevVowel\n";
        if($c eq 'a' || $c eq 'e' || $c eq 'i' || $c eq 'o' || $c eq 'u' || $c eq 'y'){
            #print "$c is vowel\n";
            if($prevVowel == 0){
                $wordSyllables = $wordSyllables + 1;
                #print "Incremented Syllables to $wordSyllables\n";              
            }
            else{
                #print "not preceeded by vowel\n";
            }  
            $prevVowel = 1;
            #print "set prev value to 1 \n";
        } 
        else{
            #print "non vowel\n";
            $prevVowel = 0;
            #print "set prev value to 0\n";
        }
        #print "$prevVowel\n";
    }
    #print "$chars[@chars-1]\n";
    if($chars[@chars-1] eq 'e'){
        #print "silent e\n";
        #print "$wordSyllables\n";
        if($wordSyllables > 1){
            #print "subtracting for silent e\n";
            $wordSyllables = $wordSyllables - 1;
        }
    }

    $numSyllables = $numSyllables + $wordSyllables;
    #print "word syllables: $wordSyllables\n"
    #print "$chars[0]\n";
    #print "$n\n";
}

$numWords = @wordArray;

print "Word count: $numWords\n";
print "sentence count: $numSentences\n";
print "syllable count: $numSyllables\n";


my $alpha = $numSyllables / $numWords;

my $beta = $numWords / $numSentences;

print "alpha $alpha\n";
print "beta $beta\n";

my $fleschIndex = 206.835 - $alpha*84.6 - $beta*1.015;
my $fleschKincaidIndex = $alpha*11.8 + $beta*0.39 - 15.59;

print "Flesch Readability Index: $fleschIndex\n";
print "Flesch-Kincaid Grade Level Index: $fleschKincaidIndex\n";

