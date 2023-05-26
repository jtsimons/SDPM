restart

# Initial values
add_force CLK {0 0ns} {1 5ns} -repeat_every 10ns
add_force START 0
add_force RESET 0
add_force OP1_IN 0
add_force OP2_IN 0
run 100ns
# Active low reset
add_force RESET 1
run 10ns

# (op2 - op1) * 2

# 1
# (0 - 0) * 2 = 0
# op1 = 00000000
# op2 = 00000000
# OVF = 0
add_force START 1
run 100ns
add_force START 0
run 150ns

# 2
# (20 - 20) * 2 = 0
# op1 = 00010100
# op2 = 00010100
# OVF = 0
add_force START 1
run 40ns
add_force START 0
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 30ns
run 150ns

# 3
# (10 - 40) * 2 = -60
# op1 = 00101000
# op2 = 00001010
# OVF = 0
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
run 150ns

# 4
# (40 - 10) * 2 = 60
# op1 = 00001010
# op2 = 00101000
# OVF = 0
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
run 150ns

# 5
# (-40 - 30) * 2 = -140
# op1 = 00011110
# op2 = 11011000
# OVF = 1 (after * 2)
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
run 150ns

# 6
# (66 - (-66)) * 2 = 264
# op1 = 10111110
# op2 = 01000010
# OVF = 1 (before * 2)
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
run 150ns

# 7
# (-10 - (-20)) * 2 = 20
# op1 = 11101100
# op2 = 11110110
# OVF = 0
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
run 150ns

# 8
# (10 - 74) * 2 = -128
# op1 = 01001010
# op2 = 00001010
# OVF = 0
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
run 150ns

# 9
# (52 - (-10)) * 2 = 124
# op1 = 11110110
# op2 = 00110100
# OVF = 0
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
run 150ns

# 10
# (42 - (-22)) = 128
# op1 = 11101010
# op2 = 00101010
# OVF = 1 (after * 2)
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
run 150ns

# 11
# (-66 - 66) * 2 = -264
# op1 = 01000010
# op2 = 10111110
# OVF = 1 (before * 2)
add_force START 1
run 10ns
add_force START 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 0
run 10ns
add_force OP1_IN 1
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
add_force OP1_IN 1
add_force OP2_IN 0
run 10ns
add_force OP1_IN 0
add_force OP2_IN 1
run 10ns
run 150ns

# RESET#
run 50ns
add_force RESET 0
run 50ns
