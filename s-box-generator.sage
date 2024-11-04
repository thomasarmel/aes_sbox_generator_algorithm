modulus2 = IntegerModRing(2)
k.<x> = GF(2^8, modulus=x^8+x^4+x^3+x+1)

multiplicative_matrix = Matrix(modulus2, [[1, 0, 0, 0, 1, 1, 1, 1],
					  [1, 1, 0, 0, 0, 1, 1, 1],
					  [1, 1, 1, 0, 0, 0, 1, 1],
					  [1, 1, 1, 1, 0, 0, 0, 1],
					  [1, 1, 1, 1, 1, 0, 0, 0],
					  [0, 1, 1, 1, 1, 1, 0, 0],
					  [0, 0, 1, 1, 1, 1, 1, 0],
					  [0, 0, 0, 1, 1, 1, 1, 1],
					  ])
 

sbox = []

for input in range(256):
	mask = 1
	poly = 0
	for input_bit in range(8):
		bit_set = input & mask != 0
		if bit_set:
			poly = poly + x^input_bit
		mask = mask * 2
	inverse_vector = vector(GF(2), [0, 0, 0, 0, 0, 0, 0, 0])
	if poly != 0: # We cannot inverse the null vector
		inverse_vector = poly.inverse()._vector_()
	inverse_mul_matrix = multiplicative_matrix * inverse_vector
	s_box_output = (ZZ(list(inverse_mul_matrix), base=2) ^^ 0x63)
	sbox.append(s_box_output)
	
	
print(sbox)
