with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
--with Ada.Boolean_Text_IO;
--use Ada.Boolean_Text_IO;
with Ada.IO_Exceptions;
use Ada.IO_Exceptions;
with Ada.Characters.Handling;
use Ada.Characters.Handling;
with Ada.Command_Line;
use Ada.Command_Line;


procedure parser is

In_File     : File_Type;
currChar, prevChar       : Character;
wordCount, sentenceCount, syllableCount, wordSyllables : Integer;
sentenceMarker, vowelCurr, vowelPrev : Boolean;
alpha, beta, fRIndex, fKGLIndex : Float;

--function isSentenceMarker (c : Character) return Boolean is
--begin
--if '.' = '.' then--or c is ";" or c is ":" or c is "!" or c is "?" then 
--    return True;
--else
--return False;
--end if;

--end isSentenceMarker; 

begin
wordCount := 0;
sentenceCount := 0;
syllableCount := 0;
prevChar := ' ';
vowelPrev := False;

Ada.Text_IO.Open(File=>In_File,Mode=>Ada.Text_IO.In_File, Name=>Argument(1));--"../translations/KJV.txt");

--pos:=0;
wordSyllables := 0;
while not End_Of_File(In_File)loop
    Ada.Text_IO.Get(File=>In_File, Item=>currChar);
    --wordSyllables := 0;
    --Ada.Text_IO.Put(Item=>currChar);
    --Put(sentenceCount);
    if(currChar = '.' or currChar = ';' or currChar = ':' or currChar = '!' or currChar = '?') then
        sentenceCount := sentenceCount + 1;
    end if;
    if( not Is_Letter(currChar)) then
        currChar := ' ';
    end if;
    
    currChar := To_Lower(currChar);

    if(currChar /= ' ' and  prevChar = ' ') then
        wordCount := wordCount + 1;
    end if;

    if(currChar = 'a' or currChar = 'e' or currChar = 'i' or currChar = 'o' or currChar = 'u' or currChar = 'y') then
        vowelCurr := True;
    else
        vowelCurr := False;
    end if;
    
    --Put("Vowel Curr: ");
    --Put(Boolean'image(vowelCurr));
    --New_Line(1);

    if(currChar = ' ') then
        if(prevChar = 'e') then
            if(wordSyllables = 0)then
                wordSyllables := 1;
            elsif(wordSyllables > 1) then
                wordSyllables := wordSyllables - 1;
            end if;
        end if;
        --New_Line(1);
        --Put(wordSyllables);
        --New_Line(1);
        syllableCount := wordSyllables + syllableCount;
        Put(syllableCount);
        wordSyllables := 0;
        --print*, input, " ", syllablesCount
    elsif(vowelCurr and not vowelPrev) then
            wordSyllables := wordSyllables + 1;
    end if;

    vowelPrev := vowelCurr;
    --!pprev = prev
    prevChar := currChar;


    --Ada.Text_IO.Put(Item=>currChar);    
    --New_Line(1);
    --prevChar := currChar;
end loop;

exception 
    when Ada.IO_Exceptions.END_ERROR => Ada.Text_IO.Close(File=>In_File);

Put(prevChar);

if(Is_Letter(prevChar)) then 
    wordCount := 1 + wordCount;
    Put_Line("Incremented word count");
end if;

wordCount := wordCount + 1;

Ada.Text_IO.New_Line;
Put(sentenceCount);
Put(wordCount);
Put(syllableCount);

alpha := float(syllableCount)/float(wordCount);
beta := float(wordCount)/float(sentenceCount);

fRIndex := 206.835 - alpha*84.6 - beta*1.015;
Put( "Flesch Readability Index: ");
Put(fRIndex);
New_Line(1);

fKGLIndex := alpha*11.8 + beta*0.39 - 15.59;
Put( "Flesch-Kincaid Grade Level Index: ");
Put(fKGLIndex);
New_Line(1);

end parser;
