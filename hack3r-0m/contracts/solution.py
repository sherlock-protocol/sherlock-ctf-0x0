tr = "6e3c5b0f722c430e6d324c0d6f67173d4b1565345915753504211f"
b = 0
decoded = ""

def gray2binary(x, s):
    shiftamount = s;
    while x >> shiftamount:
        x ^= x >> shiftamount
        shiftamount <<= 1
    return x

for i in range(0, len(tr) - 1, 2):
#Converting string to int
    a = int(tr[i:i+2],16)
#Reading previous hex string in case of i > 0
    if i > 0:
        b = int(tr[i-2:i],16)

    l=a
#Reversing right shift and XOR of 1,2,3,4
    for s in range(1,5):
        l = gray2binary(l,s)

#XORing the last
    l = l ^ b

#Storing the string
    decoded += chr(l)

print(decoded)
