----------------------------------------------------------
-- projet : thunderbird
-- auteur : P.BENABES
-- description : display the lighting of an old american car
----------------------------------------------------------

-- open the standard libraries
library ieee;
use ieee.std_logic_1164.all ;	-- définit le types std_logic std_logic_vector


-- the TOP level entity
entity clk_div is

-- defines the generic parameters (project constants)
generic (facteur : integer := 25000000);  -- facteur de division d'horloge. Ici on obtiendra 1 hz à partir de 50 Mhz

-- Input/Outputs definition
port (  RESET   :   in std_logic;		-- 50 Mhz Clock
        CLK_IN  :   in std_logic;		-- 50 Mhz Clock
        CLK_OUT :  out std_logic		-- 1 Hz clock
		  ) ;

end entity;


architecture a1 of clk_div is
  -- declaring a counter signal and logical buffer

  -- the counter will count the corresponding division
	signal clkcnt : integer := 1;

  -- the buffer is meant to store signal value that is to be assigned to the output
  -- since the CLK_OUT (std_logic) cannot be directly inverted
	signal buff : std_logic := '0';

begin
  -- clock input corresponding to internal clock of the board and reset both assigned in the sensitivity list
	process(CLK_IN, reset)

	begin

    -- when detecting rising edge at the input
		if rising_edge(CLK_IN) then
			if (clkcnt = 0) then

        -- start subtracting the divider (facteur) and assign the value to the counter
        clkcnt <= facteur - 1;

        -- affecting the buffer into 0 and inverting the current value
				buff <= '0';
				buff <= not buff;

        -- affecting the output CLK_OUT as the value of the buffer
      	CLK_OUT <= buff;
			else
        -- if the current value of counter is not zero then start recurrently decreamented
				clkcnt <= clkcnt - 1;
			end if;
		end if;

	end process;
end architecture;
