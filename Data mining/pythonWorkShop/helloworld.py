    
def is_prime(num):
    for i in range(2, num):
        if(num % i == 0):
            print(num,"is not a prime")
            print(i)
            return
    print(num,"is a prime")
    return
    
is_prime(17)