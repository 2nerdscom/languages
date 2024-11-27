with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Numerics.Discrete_Random;

procedure Code is
   subtype Random_Range is Positive;
   package Rand is new Ada.Numerics.Discrete_Random (Random_Range);
   use Rand;

   Gen : Generator;
   
   U : constant Integer := Integer'Value (Argument (1));
   R : constant Integer := Random (Gen) mod 10000;
   A : array (1 .. 10000) of Integer := [others => 0];

begin
   for I in 1 .. 10000 loop
      for J in 1 .. 100000 loop
         A (I) := A (I) + J rem U;
      end loop;

      A (I) := @ + R;
   end loop;

   Put_Line (A (R)'Image);
end Code;
