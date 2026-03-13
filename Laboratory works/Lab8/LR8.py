# Лабораторная работа №8
# Целочисленная арифметика многократной точности
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

from __future__ import annotations
DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
VAL = {ch: i for i, ch in enumerate(DIGITS)}

def digits_to_str(dig: list[int], b: int) -> str:
    dig = trim(dig[:])
    if len(dig) == 1 and dig[0] == 0:
        return "0"
    out = []
    for d in reversed(dig):
        out.append(DIGITS[d])
    return "".join(out)
    
def str_to_digits(s: str, b: int) -> list[int]:
    s = s.strip().upper()
    if s == "" or s == "0":
        return [0]
    if s.startswith("-"):
        raise ValueError("Err - <0")
    dig: list[int] = []
    for ch in reversed(s):
        if ch not in VAL:
            raise ValueError("Err - impossible symbol")
        d = VAL[ch]
        if d < 0 or d >= b:
            raise ValueError("Err - impossible digit")
        dig.append(d)
    return trim(dig)

def trim(dig: list[int]) -> list[int]:
    while len(dig) > 1 and dig[-1] == 0:
        dig.pop()
    return dig

def cmp_digits(u: list[int], v: list[int]) -> int:
    u = trim(u[:])
    v = trim(v[:])
    if len(u) != len(v):
        return -1 if len(u) < len(v) else 1
    for a, b_ in zip(reversed(u), reversed(v)):
        if a != b_:
            return -1 if a < b_ else 1
        return 0
    
def add_big(u: list[int], v: list[int], b: list[int]) -> list[int]:
    n = max(len(u), len(v))
    w = [0] * (n + 1)
    carry = 0
    for j in range(n):
        uj = u[j] if j < len(u) else 0
        vj = v[j] if j < len(v) else 0
        s = uj + vj + carry
        w[j] = s % b
        carry = s // b 

    w[n] = carry
    return trim(w)

def sub_big(u: list[int], v: list[int], b: int) -> list[int]:
    if cmp_digits(u,v) < 0:
        raise ValueError("Err u should be >= v")
    n = len(u)
    w = [0] * n
    borrow = 0
    for j in range(n):
        uj = u[j]
        vj = v[j] if j< len(v) else 0
        s = uj - vj - borrow
        if s < 0:
            s += b
            borrow = 1
        else:
            borrow = 0
        w[j] = s
    return trim(w)

def mul_classic(u: list[int], v: list[int], b: int) -> list[int]:
    u = trim(u[:])
    v = trim(v[:])
    if u == [0] or v == [0]:
        return[0]
    n, m = len(u), len(v)
    w = [0] * (n+m)
    for j in range(m):
        if v[j] == 0:
            continue
        carry = 0
        for i in range(n):
            t = u[i] * v[j] + w[i + j] + carry
            w[i + j] = t % b
            carry = t // b
        w[j + n] += carry
    carry = 0
    for k in range(len(w)):
        t = w[k] + carry
        w[k] = t % b 
        carry = t // b
    while carry > 0:
        w.append(carry % b)
        carry //= b
    return trim(w)

def mul_fast(u: list[int], v: list[int], b: int) -> list[int]:
    u = trim(u[:])
    v = trim(v[:])
    if u == [0] or v == [0]:
        return[0]
    n, m = len(u), len(v)
    w = [0] * (n+m)
    carry = 0
    for s in range(n + m - 1):
        t = carry
        i_min = max(0, s - (m-1))
        i_max = min(n - 1, s)
        for i in range(i_min, i_max + 1):
            t += u[i] * v[s-i]
        w[s] = t % b
        carry = t // b
    w[n + m - 1] = carry
    k = n + m - 1
    while w[k] >= b:
        extra = w[k] // b
        w[k] %= b
        k += 1
        if k  == len(w):
            w.append(0)
        w[k] += extra
    
    return trim(w)        

def to_be(dig_le: list[int]) -> list[int]:
    dig_le = trim(dig_le[:])
    return list(reversed(dig_le))

def to_le(dig_be: list[int]) -> list[int]:
    if not dig_be:
        return [0]
    i = 0
    while i < len(dig_be) - 1 and dig_be[i] == 0:
        i += 1
    dig_be = dig_be[i:]
    return trim(list(reversed(dig_be)))

def mul_digit_be_inplace(dig_be: list[int], d: int, b: int) -> None:
    carry = 0
    for i in range(len(dig_be) - 1, -1, -1):
        t = dig_be[i] * d + carry
        dig_be[i] = t % b
        carry = t // b
    if carry != 0:
        dig_be.insert(0, carry)

def div_digit_be(dig_be: list[int], d: int, b: int) -> list[int]:
    rem = 0
    q = []
    for x in dig_be:
        rem = rem * b + x
        q.append(rem // d)
        rem %= d
    i = 0
    while i < len(q) - 1 and q[i] == 0:
        i += 1
        return q[i:]
    

def div_big(u: list[int], v: list[int], b : int) -> tuple[list[int], list[int]]:
    u = trim(u[:])
    v = trim(v[:])

    if v == [0]:
        raise ZeroDivisionError("Err")
    if u == [0]:
        return [0], [0]
    if cmp_digits(u,v) < 0:
        return [0], u
    if v == [1]:
        return u, [0]
    U = to_be(u)
    V = to_be(v)
    n = len(V)
    m = len(U) - n
    uu = [0] + U[:]
    vv = V[:]
    d = b // (vv[0] + 1)
    if d > 1:
        mul_digit_be_inplace(uu, d, b)
        mul_digit_be_inplace(vv, d, b)

    n = len(vv)
    m = len(uu) - n - 1
    q = [0] * (m+1)

    v0 = vv[0]
    v1 = vv[1] if n > 1 else 0

    for j in range (m + 1):
        u0 = uu[j]
        u1 = uu[j + 1]
        numer = u0 * b + u1
        qhat = numer // v0
        rhat = numer % v0
        if qhat >= b:
            qhat = b - 1
            rhat += v0
        if n > 1:
            u2 = uu[j + 2]
            while qhat * v1 > rhat * b + u2:
                qhat -= 1
                rhat += v0
                if rhat >= b:
                    break

        borrow = 0
        for i in range(n-1, -1, -1):
            p = qhat * vv[i] + borrow
            idx = j + i + 1
            t = uu[idx] - (p % b)
            borrow = p // b
            if t < 0:
                t += b
                borrow += 1
            uu[idx] = t
        t0 = uu[j] - borrow
        if t0 < 0:
            qhat -= 1
            t0 += b 
            carry = 0
            for i in range(n -1,-1,-1):
                idx = j + i  + 1
                t = uu[idx] + vv[i] + carry
                if t >= b:
                    t -=b
                    carry = 1
                else:
                    carry = 0
                uu[idx] = t
            uu[j] = t0 + carry
            if uu[j] >= b:
                uu[j] -= b
        else:
            uu[j] = t0
        q[j] = qhat

    r = uu[m + 1 :]
    if d > 1:
        r = div_digit_be(r,d,b)

    q_le = to_le(q)
    r_le = to_le(r)
    return q_le, r_le

def read_base() -> int:
    s = input("Введите основание b (2-36)").strip()
    b = int(s)
    if not (2 <= b <= 36):
        raise ValueError("Err b")
    return b

def read_number(prompt: str, b: int) -> list[int]:
    s = input(prompt).strip()
    return str_to_digits(s, b)

def main():
    print("0 - exit")
    print("1 - сложение")
    print("2 - вычитание")
    print("3 - умножение столбиком (классическое)")
    print("4 - умножение быстрым столбиком")
    print("5 - деление с отстатком\n")

    while True:
        choice = input("Выберите алгоритм (0 для выхода): ").strip()
        if choice == "0":
            print("До свидания!")
            break

        if choice not in {"1", "2", "3", "4", "5"}:
            print("Неверный выбор. Выберите 0..5.\n")
            continue

        try:
            b = read_base()
            u = read_number("Введите u: ", b)
            v = read_number("Введите v: ", b)

            if choice == "1":
                w = add_big(u, v, b)
                print("u + v =", digits_to_str(w, b))

            elif choice == "2":
                c = cmp_digits(u, v)
                if c == 0:
                    print("u - v = 0")
                elif c > 0:
                    w = sub_big(u, v, b)
                    print("u - v =", digits_to_str(w, b))
                else:
                    w = sub_big(v, u, b)
                    print("u - v = -" + digits_to_str(w, b))

            elif choice == "3":
                w = mul_classic(u, v, b)
                print("u * v =", digits_to_str(w, b))

            elif choice == "4":
                w = mul_fast(u, v, b)
                print("u * v =", digits_to_str(w, b))

            elif choice == "5":
                q, r = div_big(u, v, b)
                print("q =", digits_to_str(q, b))
                print("r =", digits_to_str(r, b))

            print()
        except Exception as e:
            print("Err ", e, "\n")

if __name__ == "__main__":
    main()




