----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Selahattin ABAKAY
-- 
-- Create Date: 14.05.2024 18:26:33
-- Design Name: FLash Memory Register File
-- Module Name: register_file - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity register_file is
Port ( 
            CLK     :   in  std_logic;
            RST     :   in  std_logic;
            
            write_enable    :   in  std_logic;
            read_enable     :   in  std_logic;
            
            data_in         :   in  std_logic_vector(31 downto 0);
            data_out        :   out std_logic_vector(31 downto 0);
            address         :   in  std_logic_vector(7 downto 0);
            
            write_data      :   out std_logic_vector(31 downto 0);
            read_data       :   in  std_logic_vector(31 downto 0);
            addr_data       :   out std_logic_vector(31 downto 0);
            command_data    :   out std_logic_vector(31 downto 0);
            send_data       :   out std_logic_vector(31 downto 0)
            
);
end register_file;

architecture Behavioral of register_file is

signal write_data_signal      :   std_logic_vector(31 downto 0);
signal read_data_signal       :   std_logic_vector(31 downto 0);
signal addr_data_signal       :   std_logic_vector(31 downto 0);
signal command_data_signal    :   std_logic_vector(31 downto 0);
signal send_data_signal       :   std_logic_vector(31 downto 0);
begin
write_data          <=  write_data_signal;
read_data_signal    <=  read_data;
addr_data           <=  addr_data_signal;
command_data        <=  command_data_signal;
send_data           <=  send_data_signal;
process(CLK, RST) 

begin
if(rising_edge(CLK)) then
        if(RST = '1')   then
    data_out        <=  (others =>  '1');
            else 
                if(read_enable  =   '1')    then
            case address is
                when    x"00"   =>
                data_out    <=  write_data_signal;
                when    x"04"   =>
                data_out    <=  read_data_signal;
                when    x"08"   =>
                data_out    <=  addr_data_signal;
                when    x"0C"   =>
                data_out    <=  command_data_signal;
                when    x"10"   =>
                data_out    <=  send_data_signal;
                when    others  =>
                data_out    <=  x"11111111";
            end case;
                end if;
        end if;
end if;
end process;

process(CLK,    RST)    

begin
if(rising_edge(CLK)) then
    if(RST  =   '1')    then
        write_data_signal   <=  (others => '0');
        addr_data_signal    <=  (others => '0');
        command_data_signal <=  (others => '0');
        send_data_signal    <=  (others => '0');
        
        else
        if(write_enable =   '1')    then
        case    address is
        when    x"00"   =>
        write_data_signal   <=  data_in;
        when    x"08"   =>
        addr_data_signal    <=  data_in;
        when    x"0C"   =>
        command_data_signal <=  data_in;
        when    x"10"   =>
        send_data_signal    <=  data_in;
        when others =>
        null;
        end case;
        end if;
    end if;
end if;
end process;
end Behavioral;
