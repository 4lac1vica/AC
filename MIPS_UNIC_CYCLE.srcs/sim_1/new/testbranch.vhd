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

    -- Semnale interne
    signal sw  : std_logic_vector(2 downto 0) := (others => '0');
    signal bt1 : std_logic := '0';
    signal bt0 : std_logic := '0';
    signal clk : std_logic := '0';
    signal cat : std_logic_vector(6 downto 0);
    signal an  : std_logic_vector(7 downto 0);
    signal led : std_logic_vector(10 downto 0);

    -- Semnal nou pentru capturarea rezultatului
    signal digits_tb : std_logic_vector(31 downto 0) := (others => '0');

begin

    -- Instan?ierea test_env
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
        while now < 6000 ns loop
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
        -- Reset
        bt1 <= '1';
        wait for 20 ns;
        bt1 <= '0';

        -- Enable
        wait for 30 ns;
        bt0 <= '1';
        wait for 10 ns;
        bt0 <= '0';

        -- Select wb (write back) pe SSD
        wait for 100 ns;
        sw <= "111";

        wait;
    end process;

    -- Captur?m rezultatul write back
    digits_tb <= uut.wb;  -- ? captur?m rezultatul final

end sim;
