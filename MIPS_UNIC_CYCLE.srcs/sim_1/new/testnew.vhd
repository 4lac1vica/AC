library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity testnew is
end testnew;

architecture sim of testnew is

    component test_env
        Port(
            sw  : in  std_logic_vector(2 downto 0);
            bt1 : in  std_logic;
            bt0 : in  std_logic;
            clk : in  std_logic;
            cat : out std_logic_vector(6 downto 0);
            an  : out std_logic_vector(7 downto 0);
            led : out std_logic_vector(10 downto 0)
        );
    end component;

    -- Semnale interne
    signal sw  : std_logic_vector(2 downto 0) := (others => '0');
    signal bt1 : std_logic := '0';
    signal bt0 : std_logic := '0';
    signal clk : std_logic := '0';
    signal cat : std_logic_vector(6 downto 0);
    signal an  : std_logic_vector(7 downto 0);
    signal led : std_logic_vector(10 downto 0);

begin

    
    uut: test_env port map(
        sw  => sw,
        bt1 => bt1,
        bt0 => bt0,
        clk => clk,
        cat => cat,
        an  => an,
        led => led
    );

    
    clk_process : process
    begin
        while now < 5000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    
    stim_proc: process
    begin
        
        bt1 <= '0';

        
        bt0 <= '1'; 

        
        wait for 50 ns;
        sw <= "000";

        
        wait for 2000 ns;

        wait;
    end process;

end sim;
