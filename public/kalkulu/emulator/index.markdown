<script type="text/javascript">
//<![CDATA[

// config
num_registers = 15; // Number of general-purpose registers
mem_size = 500; // In bytes

// actual emulator

function bin2dec(b) {
	return parseInt(b.toString(), 2);
}

// Operands/opcodes/etc -- hideous, but I wanted them stored as their binary values
loadr  = bin2dec("00000000");
loadv  = bin2dec("00000001");
storer = bin2dec("00000010");
storev = bin2dec("00000011");
inr    = bin2dec("00000100");
inv    = bin2dec("00000101");
outr   = bin2dec("00000110");
outv   = bin2dec("00000111");
movr   = bin2dec("00001000");
movv   = bin2dec("00001001");
addr   = bin2dec("00001010");
addv   = bin2dec("00001011");
subr   = bin2dec("00001100");
subv   = bin2dec("00001101");
andr   = bin2dec("00001110");
andv   = bin2dec("00001111");
orr    = bin2dec("00010000");
orv    = bin2dec("00010001");
xorr   = bin2dec("00010010");
xorv   = bin2dec("00010011");
shlr   = bin2dec("00010100");
shlv   = bin2dec("00010101");
shrr   = bin2dec("00010110");
shrv   = bin2dec("00010111");
jmpr   = bin2dec("00011000");
jmpv   = bin2dec("00011001");
jzr    = bin2dec("00011010");
jzv    = bin2dec("00011011");
ltr    = bin2dec("00011100");
ltv    = bin2dec("00011101");
gtr    = bin2dec("00011110");
gtv    = bin2dec("00011111");
eqr    = bin2dec("00100000");
eqv    = bin2dec("00100001");
iret   = bin2dec("11111111");

// Flags
status = 0;
carry = 1;
zero = 2;

// Registers default to all zeros
var registers = new Array(num_registers + 4); // add four for the flag, int number, int handler, and instruction pointer registers

// Memory defaults to all zeros
var memory = new Array(mem_size); // memory size in bytes

setFlags = function(status, carry, zero) {
	registers[0] = 0;
	if(status) {
		registers[0] += (1 | status);
	}

	if(carry) {
		registers[0] += (2 | carry);
	}

	if(zero) {
		registers[0] += (3 | zero);
	}
	return [status, carry, zero]
}

isFlagSet = function(which) {
	if(registers[0] & which) {
		return 1;
	} else {
		return 0;
	}
}

intNumber = function() {
        return registers[1];
}

setIntNumber = function(n) {
        registers[1] = n;
        return n;
}

intHandler = function() {
	return registers[2];
}

// You may expect setIntHandler(), but that's never done internally so it's unneeded.

instPointer = function() {
	return registers[3];
}

setInstPointer = function(n) {
	registers[3] = n;
	return registers[3];
}

step = function(cmd, in1, in2) {
	switch(cmd) {
	case loadr:
		registers[in1] = memory[registers[in2]];
		break;
	case loadv:
		registers[in1] = memory[in2];
		break;
	case storer:
		memory[registers[in1]] = registers[in2];
		break;
	case storev:
		memory[registers[in1]] = in2;
		break;
	case inr:
		break;
	case inv:
		break;
	case outr:
		break;
	case outv:
		break;
	case movr:
		registers[in1] = registers[in2];
		break;
	case movv:
		registers[in1] = in2;
		break;
	case addr:
		registers[in1] += registers[in2];
		break;
	case addv:
		registers[in1] += in2;
		break;
	case subr:
		registers[in1] -= registers[in2];
		break;
	case subv:
		registers[in1] -= in2;
		break;
	case andr:
		registers[in1] &= registers[in2];
		break;
	case andv:
		registers[in1] &= in2;
		break;
	case orr:
		registers[in1] |= registers[in2];
		break;
	case orv:
		registers[in1] |= in2;
		break;
	case xorr:
		registers[in1] ^= registers[in2];
		break;
	case xorv:
		registers[in1] ^= in2;
		break;
	case shlr:
		registers[in1] = (registers[in1] << registers[in2]);
		break;
	case shlv:
		registers[in1] = (registers[in1] << in2);
		break;
	case shrr:
		registers[in1] = (registers[in1] >> registers[in2]);
		break;
	case shrv:
		registers[in1] = (registers[in1] >> in2);
		break;
	case jmpr:
		setInstPointer(registers[in1]);
		break;
	case jmpv:
		setInstPointer(in1);
		break;
	case jzr:
		if(isFlagSet(zero))
			setInstPointer(registers[in1]);
		break;
	case jzv:
		if(isFlagSet(zero))
			setInstPointer(in1);
		break;
	case ltr:
		tmp = (registers[in1] < registers[in2]) ? 1 : 0;
		setFlags(1, 0, tmp)
		break;
	case ltv:
		tmp = (registers[in1] < in2) ? 1 : 0;
		setFlags(1, 0, tmp);
		break;
	case gtr:
		tmp = (registers[in1] > registers[in2]) ? 1 : 0;
		setFlags(1, 0, tmp);
		break;
	case gtv:
		tmp = (registers[in1] > in2) ? 1 : 0;
		setFlags(1, 0, tmp);
		break;
	case eqr:
		tmp = (registers[in1] == registers[in2]) ? 1 : 0;
		setFlags(1, 0, tmp);
		break;
	case eqv:
		tmp = (registers[in1] == in2) ? 1 : 0;
		setFlags(1, 0, tmp);
		break;
	case iret:
		break;
	}
}

run = function(code) {
	for(i = 0; i < code.length(); i += 3) {
		step(code[i], code[i+1], code[i+3]);
	}
}

init = function() {
	
}

window.onload = init;
//]]>
</script>
