# Лабораторная работа №6
# Разложение чисел на множители
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

import math
def pollard(n: int):
    a = 1
    b = 1
    i = 1

    def f(x:int) -> int:
        return(x*x+5) % n
    print(" i\t a\t\t b\t\t d")

    while True:
        a = f(a)
        b = f(f(b))
        d = math.gcd(abs(a-b), n)

        print(f"{i}\t {a}\t {b}\t {d}")
        if i < d < n:
            print(f"\n Нетривиальный делитель: {d} и {n // d}")
            break
        if d == n:
            print(" Попытка найти делитель провалилась")
            break

if __name__ == "__main__":
    n_str = input("n = ").strip()
    n = int(n_str)
    pollard(n)
