import sys

alphabet = ['A','B','C','D','E','F','G','H','I','J',
            'K','L','M','N','O','P','Q','R','S','T',
            'U','V','W','X','Y','Z']
def encript(shift, message):
    new_message = ''
    for i in range(len(message)):
        if(message[i] == ' '):
            new_message += ' '
        else:
            new_index = ((ord(message[i]) - ord('A')) + shift) %  (len(alphabet))
            new_letter = alphabet[new_index]
            new_message += new_letter
    return  new_message

def decript(shift, message):
    new_message = ''
    for i in range(len(message)):
        if(message[i] == ' '):
            new_message += ' '
        else:
            new_index = ((ord(message[i]) - ord('A')) - shift) %  (len(alphabet))
            new_letter = alphabet[new_index]
            new_message += new_letter
    return  new_message

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Need more arguments")
        exit(1)
    option = sys.argv[1]
    shifting = int(sys.argv[2])
    message = sys.argv[3].upper()


    if(option == "-e"):
        print(encript(shifting, message))
    elif(option == "-d"):
        print(decript(shifting, message))

