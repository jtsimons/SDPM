library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SDPM is
	port (
		-- Inputs
		START: in std_logic;
		CLK: in std_logic;
		RESET: in std_logic;
		OP1_IN, OP2_IN: in std_logic;
		-- Outputs
		DONE: out std_logic;
		OVF: out std_logic;
		BUFEN, SRCT1, SRCT2: out std_logic_vector(1 downto 0);
		OP_LD: out std_logic;
		RES_LD: out std_logic;
		RES_OUT: out std_logic;
		RESET_OUT: out std_logic_vector(1 downto 0);
		RES_LED: out std_logic_vector(7 downto 0)
	);
end SDPM;

architecture BEHAVIORAL of SDPM is

	type state is (
		idle_s, pload_s, sload_s, hold_s, arith_s, res_s, done_s
	);

	-- Define states/signals for serial data processing module
	signal present_s, next_s: state := idle_s;
	signal op1, op2, res: unsigned(7 downto 0);
	signal ovf_flag: std_logic := '0';
	signal ld_ctr, res_ctr: integer := 0;
	constant num_bits: integer := 7;
	
begin

	-- Finite state machine process
	FSM: process(START, OP1_IN, OP2_IN, ld_ctr, res_ctr, ovf_flag, op1, op2, res, present_s)
	begin
		-- Initial values
		DONE <= '0';
		OVF <= '0';
		BUFEN <= "11";
		SRCT1 <= "00";
		SRCT2 <= "00";
		OP_LD <= '0';
		RES_LD <= '0';
		RES_LED <= (others => '0');
		-- Handle present/next state
		case present_s is
			-- Idle state
			when idle_s =>
				DONE <= '1';
				if (START = '1') then
					next_s <= pload_s;
				else
					next_s <= idle_s;
				end if;
			-- Parallel load state
			when pload_s =>
				OP_LD <= '1';
				-- Enable buffers
				SRCT1 <= "11";
				SRCT2 <= "11";
				BUFEN <= "00";
				next_s <= sload_s;
			-- Shift right/serial load state
			when sload_s =>
				OP_LD <= '1';
				SRCT1 <= "01";
				SRCT2 <= "01";
				-- START deasserted, check bit count and prepare to perform the operation
				if (ld_ctr = num_bits) and (START = '0') then
					next_s <= arith_s;
				-- START asserted, hold
				elsif (ld_ctr = num_bits) and (START = '1') then
					next_s <= hold_s;
				-- Else, keep loading
				else
					next_s <= sload_s;
				end if;
			-- Hold state
			when hold_s =>
				-- Wait for user to deassert START
				if (START = '0') then
					next_s <= arith_s;
				else
					next_s <= hold_s;
				end if;
			-- Arithmetic operation state
			when arith_s =>
				next_s <= res_s;
			-- Result out state
			when res_s =>
				RES_LD <= '1';
				-- Shift res out
				SRCT1 <= "01";
				SRCT2 <= "01";
				if (res_ctr = num_bits) then
					next_s <= done_s;
				else
					next_s <= res_s;
				end if;
			-- Done
			when others =>
				DONE <= '1';
				OVF <= ovf_flag;
				RES_LED <= std_logic_vector(res);
				-- If START asserted, begin loading again
				if (START = '1') then
					next_s <= pload_s;
				-- Else, done
				else
					next_s <= done_s;
				end if;
		end case;
	end process FSM;

	-- Shift process
	shift: process(CLK, ld_ctr, res_ctr, ovf_flag, op1, op2, res)
	begin
		if (rising_edge(CLK)) then
			case present_s is
				-- Idle state
				when idle_s =>
					-- Set op1, op2, res, and RES_OUT signals low
					RES_OUT <= '0';
					op1 <= (others => '0');
					op2 <= (others => '0');
					res <= (others => '0');
				-- Shift right
				when sload_s =>
					RES_OUT <= '0';
					ovf_flag <= '0';
					op1(ld_ctr) <= OP1_IN;
					op2(ld_ctr) <= OP2_IN;
				-- Check overflow
				when res_s =>
					-- Multiplication: If leading two bits of res are different, sign will change when shifted out
					if ((res(7) = '0' and res(6) = '1') or (res(7) = '1' and res(6) = '0')) then
						ovf_flag <= '1';
					-- Subtraction: op1 and op2 signs are different and res MSB = op1 MSB
					elsif ((op1(7) /= op2(7)) and (res(7) = op1(7))) then
						ovf_flag <= '1';
					else
						ovf_flag <= '0';
					end if;
					RES_OUT <= res(res_ctr);
				-- Subtract
				when arith_s =>
					res <= op2 - op1;
				when others =>
			end case;
		end if;
	end process shift;

	-- Counters process
	counters: process(CLK, ld_ctr, res_ctr)
	begin
		if (rising_edge(CLK)) then
			case present_s is
				-- In shift right state, increment load bits counter
				when sload_s =>
					ld_ctr <= ld_ctr + 1;
				-- In result out state, increment result bits counter
				when res_s =>
					res_ctr <= res_ctr + 1;
				-- All other states, reset load/result counters
				when others =>
					ld_ctr <= 0;
					res_ctr <= 0;
			end case;
		end if;
	end process counters;

	-- Clock process
	clock: process(CLK, RESET)
	begin
		-- Active low reset
		if (RESET = '0') then
			present_s <= idle_s;
		elsif (rising_edge(CLK)) then
			present_s <= next_s;
		end if;
	end process clock;

	-- Fill RESET_OUT bits with RESET status
	RESET_OUT <= (others => RESET);

end BEHAVIORAL;
