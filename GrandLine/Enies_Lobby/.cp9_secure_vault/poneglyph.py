import base64

ENCODED = input("Enter code : ")
KEY = 0x42

decoded = base64.b64decode(ENCODED)
flag = bytes(b ^ KEY for b in decoded).decode()

print("Prize : ")
print(flag)
