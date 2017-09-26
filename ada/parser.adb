with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
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
sentenceMarker, vowelCurr, vowelPrev, printed : Boolean;
alpha, beta, fRIndex, fKGLIndex : Float;

begin
wordCount := 0;
sentenceCount := 0;
syllableCount := 0;
prevChar := ' ';
vowelPrev := False;

-- open translation file
Ada.Text_IO.Open(File=>In_File,Mode=>Ada.Text_IO.In_File, Name=>Argument(1));

wordSyllables := 0;
while not End_Of_File(In_File)loop
    -- read file char by char
    Ada.Text_IO.Get(File=>In_File, Item=>currChar);
    --Put(currChar);
    -- increment sentence marker count
    if(currChar = '.' or currChar = ';' or currChar = ':' or currChar = '!' or currChar = '?') then
        sentenceCount := sentenceCount + 1;
    end if;

    -- remove non-chars
    if( not Is_Letter(currChar)) then
        currChar := ' ';
    end if;
    
    currChar := To_Lower(currChar);

    --  increment word count based on chars and spaces
    if(currChar /= ' ' and  prevChar = ' ') then
        wordCount := wordCount + 1;
    end if;

    -- check if currChar is vowel
    if(currChar = 'a' or currChar = 'e' or currChar = 'i' or currChar = 'o' or currChar = 'u' or currChar = 'y') then
        vowelCurr := True;
    else
        vowelCurr := False;
    end if;
    
    -- count syllables
    if(currChar = ' ') then
        -- silent e
        if(prevChar = 'e') then
            if(wordSyllables = 0)then
                wordSyllables := 1;
            elsif(wordSyllables > 1) then
                wordSyllables := wordSyllables - 1;
            end if;
        end if;
        
        -- base case
        syllableCount := wordSyllables + syllableCount;

        wordSyllables := 0;
        
    elsif(vowelCurr and not vowelPrev) then
            wordSyllables := wordSyllables + 1;
    end if;

    --Put(currChar);

    vowelPrev := vowelCurr;
    
    prevChar := currChar;

end loop;

--Put("EOF");
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
printed := True;

exception 
    when Ada.IO_Exceptions.END_ERROR => Ada.Text_IO.Close(File=>In_File);


if ( printed /= True ) then
    --calculate and print Flesch Indeces
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
end if;

end parser;
