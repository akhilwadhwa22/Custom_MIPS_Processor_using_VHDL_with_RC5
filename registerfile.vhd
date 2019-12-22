LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; --use CONV_INTEGER
ENTITY RAM IS
 PORT  (clk: IN STD_LOGIC;
        reset : in STD_LOGIC;
        sel : in STD_LOGIC_VECTOR(4 downto 0) := "00000";
        writeEN: in STD_LOGIC; --read =0; write =1
        rs: IN STD_LOGIC_VECTOR(4 DOWNTO 0);--5-bit address
        rt: IN STD_LOGIC_VECTOR(4 DOWNTO 0);--5-bit address
        rd: IN STD_LOGIC_VECTOR(4 DOWNTO 0);--5-bit address
        datain: in STD_LOGIC_VECTOR(31 DOWNTO 0) ;--32-bit datain
        dataout1: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --32-bit data out);
        dataout2: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        regfile1 : OUT STD_LOGIC_VECTOR(31 downto 0)); --32-bit data out);
END RAM;
ARCHITECTURE RTL OF RAM IS

TYPE ram IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL regs: ram:= (others => x"00000000");

BEGIN 

PROCESS(clk, reset)  
BEGIN
IF(reset = '1') then
    regs <= (others => x"00000000");

ELSIF(rising_edge(clk))  THEN 
    if (writeEN ='1') then 
         if(CONV_INTEGER(rd)/=0) then    
            regs(CONV_INTEGER(rd)) <= datain(31 downto 0); --should be dependent on the mux output 
         end if;
    end if;
end if;

END PROCESS;

dataout1 <= regs(CONV_INTEGER(rs));
dataout2 <= regs(CONV_INTEGER(rt));

process(sel)
begin

regfile1 <= regs(CONV_INTEGER(sel));

end process;

END RTL;