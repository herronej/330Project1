program reader2

character(LEN=5000000)::long_string
integer::filesize

call read_file(long_string, filesize)

end program reader2

subroutine read_file(string, counter)
character(LEN=*)::string
character(LEN=32)::arg
integer::counter
character(LEN=1)::input, prev
real::wordCount
real::sentenceCount
real::syllablesCount, wordSyllables
logical:: sentenceMarker, vowelIn, vowelPrev

wordCount = 0.0
sentenceCount = 0.0
syllablesCount = 0.0
prev = " "

call getarg(1, arg)

open (unit=5, status = "old",access="direct",form="unformatted",recl=1,file=trim(arg))

counter=1
wordSyllables = 0.0
100 read (5, rec=counter,err=200) input
    counter=counter+1
    call isSentenceMarker(input, sentenceMarker)
    call clean_char(input)
    if(sentenceMarker) then
        sentenceCount = sentenceCount + 1
    end if
    if(input /= " " .and. prev == " ") then
        wordCount = wordCount + 1.0
    end if

    call isVowel(input, vowelIn)

    if(input == " ") then
        if(prev == "E") then 
            if(wordSyllables == 0.0)then
                wordSyllables = 1.0;
            else if(wordSyllables > 1.0) then
                wordSyllables = wordSyllables - 1.0;
            end if
        end if
        
        syllablesCount = wordSyllables + syllablesCount
        wordSyllables = 0
        
    else
        if(vowelIn .and. .not. vowelPrev) then
            wordSyllables = wordSyllables + 1
        end if
    end if

    vowelPrev = vowelIn
    prev = input
    string(counter:counter)=input
    goto 100
200 continue
counter=counter-1

close(5)
print*,"Word Count: ", wordCount," words."
print*,"Sentence Count: ",sentenceCount," sentences."
print*,"Num Syllables: ", syllablesCount," syllables."

call getFleschIndex(wordCount, sentenceCount, syllablesCount)
call getFleschKincaidIndex(wordCount, sentenceCount, syllablesCount)

end subroutine read_file


subroutine getFleschIndex(wordCount, sentenceCount, syllablesCount)
real::wordCount, sentenceCount, syllablesCount, alpha, beta, fIndex
alpha = syllablesCount/wordCount
beta = wordCount/sentenceCount    


fIndex = 206.835 - alpha*84.6 - beta*1.015
print*, "Flesch Readability Index: ", fIndex
end subroutine getFleschIndex


subroutine getFleschKincaidIndex(wordCount, sentenceCount, syllablesCount)
real::wordCount, sentenceCount, syllablesCount, alpha, beta, fIndex
alpha = syllablesCount/wordCount
beta = wordCount/sentenceCount

fIndex = alpha*11.8 + beta*0.39 - 15.59
print*, "Flesch-Kincaid Grade Level Index: ", fIndex
end subroutine getFleschKincaidIndex


subroutine isVowel(charNext, vowel)
character(len=1) :: charNext
logical :: vowel 
vowel = (charNext == "A" .or. charNext == "E" .or. charNext == "I" .or. charNext == "O" .or. charNext == "U" .or. charNext == "Y")
end subroutine isVowel

subroutine isSentenceMarker(charNext, sentenceMarker)
character(len=1) :: charNext
logical :: sentenceMarker

sentenceMarker = (charNext == "." .or. charNext == ":" .or. charNext == ";" .or. charNext == "!" .or. charNext == "?")

end subroutine isSentenceMarker

subroutine clean_char(charNext)
character(len=1) :: charNext
integer :: j, e
logical :: is_numeric
real :: x
j = iachar(charNext(1:1))
if(j>=iachar("a") .and. j<=iachar("z")) then 
    charNext(1:1) = achar(iachar(charNext(1:1))-32)
end if

if((j<iachar("A"))) then
  charNext(1:1) = " "
end if

if(j > ichar("Z") .and. j < 61) then
    charNext(1:1) = " "
end if

if(charNext == "]" .or. charNext == "[") then
    charNext(1:1) = " "
end if

read(charNext,*, iostat = e) x
is_numeric = e == 0
if(is_numeric ) then
    charNext(1:1) = " "
end if
end subroutine clean_char
