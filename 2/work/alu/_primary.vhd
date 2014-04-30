library verilog;
use verilog.vl_types.all;
entity alu is
    generic(
        c_add           : integer := 1;
        c_sub           : integer := 2;
        c_inc           : integer := 3;
        c_dec           : integer := 4;
        c_or            : integer := 5;
        c_and           : integer := 6;
        c_xor           : integer := 7;
        c_shr           : integer := 8;
        c_shl           : integer := 9;
        c_onescomp      : integer := 10;
        c_twoscomp      : integer := 11
    );
    port(
        in_a            : in     vl_logic_vector(7 downto 0);
        in_b            : in     vl_logic_vector(7 downto 0);
        opcode          : in     vl_logic_vector(3 downto 0);
        alu_out         : out    vl_logic_vector(7 downto 0);
        alu_zero        : out    vl_logic;
        alu_carry       : out    vl_logic
    );
end alu;
