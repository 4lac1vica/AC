library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_test_env is
end tb_test_env;

architecture sim of tb_test_env is

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

    -- Signals to connect
    signal sw  : std_logic_vector(2 downto 0) := (others => '0');
    signal bt1 : std_logic := '0'; -- reset
    signal bt0 : std_logic := '0'; -- enable
    signal clk : std_logic := '0'; -- clock
    signal cat : std_logic_vector(6 downto 0);
    signal an  : std_logic_vector(7 downto 0);
    signal led : std_logic_vector(10 downto 0);

begin

    uut: test_env port map(
        sw => sw,
        bt1 => bt1,
        bt0 => bt0,
        clk => clk,
        cat => cat,
        an => an,
        led => led
    );

    -- Clock generator
    clk_process : process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimuli
    stim_proc: process
    begin
        -- Initial reset
        bt1 <= '1';
        wait for 20 ns;
        bt1 <= '0';

        -- Enable pulse
        wait for 30 ns;
        bt0 <= '1';
        wait for 10 ns;
        bt0 <= '0';

        -- Change switches to show wb
        wait for 40 ns;
        sw <= "111";

        wait;
    end process;

end sim;
