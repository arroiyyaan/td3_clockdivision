----------------------------------------------------------
-- projet : thunderbird
-- auteur : P.BENABES
-- description : display the lighting of an old american car
----------------------------------------------------------

-- open the standard libraries
library ieee;
use ieee.std_logic_1164.all ;	-- définit le types std_logic std_logic_vector
use IEEE.numeric_std.all; -- this libary is required to perform the arihtmetic operation

-- the TOP level entity
entity clk_div2 is

-- defines the generic parameters (project constants)
-- generic (facteur : integer := 25000000);  -- facteur de division d'horloge. Ici on obtiendra 1 hz à partir de 50 Mhz

-- Input/Outputs definition
port (  RESET   : in std_logic;		-- 50 Mhz Clock
		    facteur : in std_logic_vector (3 downto 0); -- now instead of fixing the value of facteur, it is made adjustable 4-bits by input
        CLK_IN  : in std_logic;		-- 50 Mhz Clock
        CLK_OUT : out std_logic		-- 1 Hz clock
		  ) ;

end entity;


architecture a1 of clk_div2 is
	-- declaring an unsigned counter signal and logical buffer

	-- the counter is changed to unsigned due to division operation ahead
	signal clkcnt : unsigned(3 downto 0);

	-- the buffer remains logical
	signal buff : std_logic := '0';

begin
	-- the sensitivity list remain the same with the previous code as well
	process(CLK_IN, reset)

	begin
		-- when rising edge is detected
		if rising_edge(CLK_IN) then
			if (clkcnt = 0) then

				-- if the current value of the counter is not zero,
				-- the 4-bits facteur is type-casted to unsigend to acommodate value transfer to the counter
				clkcnt <= unsigned(facteur);
				-- the output is set to high logical value
				CLK_OUT <= '1';

				-- the second possible condition to be evaluated is,
				-- if the counter is equal to the type-casted facteur divided by 2 plus 1
			elsif clkcnt = unsigned(facteur)/2+1 then

				-- the output is set to low
				CLK_OUT <= '0';

				-- and the counter starts to be decreamented
				clkcnt <= clkcnt - 1;

			else
				-- ohterwise, the counter decreament is the only action out of other conditions
				clkcnt <= clkcnt - 1;
			end if;
		end if;

		clkcnt <= clkcnt - 1;

	end process;
end architecture;
