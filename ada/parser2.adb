with Ada.Text_IO;
with Ada.IO_Exceptions;
use Ada.Text_IO;
use Ada.IO_Exceptions;

procedure parser2 is

In_File     :Ada.Text_IO.File_Type;
value       :Character;
string_array:array(1..5000000) of Character;
pos         :integer;

begin

Ada.Text_IO.Open(File=>In_File, Mode=> Ada.Text_IO.In_File,Name=>"../translations/KJV.txt");

pos:=0;
while not Ada.Text_IO.End_Of_File(In_File) loop
    Ada.Text_IO.Get(File=>In_File, Item=>value);
    pos:=pos+1;
    string_array(pos):=value;
end loop;

exception 
    when Ada.IO_Exceptions.END_ERROR=>Ada.Text_IO.Close(File=>In_File);

for i in 1..pos loop
    Ada.Text_IO.Put(Item=>string_array(i));
end loop;


Ada.Text_IO.New_Line;

end parser2;
