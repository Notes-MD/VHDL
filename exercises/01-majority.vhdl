-- return 1 only when majority is 1

entity majority is
    port (a, b, c : in  bit;
          m       : out bit);
end majority;

architecture exercise of majority is
begin
    m <= (a and b) or (b and c) or (c and a);
end architecture exercise;
