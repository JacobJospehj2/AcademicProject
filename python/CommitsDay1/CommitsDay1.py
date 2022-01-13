
if __name__ == '__main__':
    s = "#$%@^&*kjnk svskjnbui h 4oi3hheuh /dfh uidshvhdsuihv suihc 0hrem89m4c02mw4xo;,wh fwhncoishmxlxfkjsahnxu83v 08 n8OHOIHIOMOICWHOFCMHEOFMCOEJMC0J09C 03J J3L;JMFC3JM3JC3'JIOO9MMJ099U N090N9 OOHOLNHNLLKNLKNKNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000"
    m=0
    n=0
    p=0
    q=0
    r=0
    print(range(len(s)))
    print(any(char.isalnum() for char in s))  
    for i in range(len(s)):  
        if s[i].isalpha():
            n=n+1
        else:
            n=n+0
        if s[i].isnumeric():
            p=p+1
        else:
            p=p+0
        if s[i].islower():
            q=q+1
        else:
            q=q+0
        if s[i].isupper():
            r=r+1
        else:
            r=r+0    
          
    if n>0:
        print(True)
    else:
        print(False)
    if p>0:
        print(True)
    else:
        print(False)
    if q>0:
        print(True)
    else:
        print(False)
    if r>0:
        print(True)
    else:
        print(False)