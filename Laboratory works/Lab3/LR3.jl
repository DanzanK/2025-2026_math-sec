# Лабораторная работа №3
# Шифрование гаммированием
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

a = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")

while true
    println("ш - шифрование, р - расшифровка, в - выход")
    c = lowercase(strip(readline()))
    c == "в" && break
    c in ["ш","р"] || continue

    print("Введите сообщение:")
    t = filter(x -> x in a, collect(lowercase(readline())))

    print("Введите значение гамма:")
    g = filter(x -> x in a, collect(lowercase(readline())))

    length(t) == 0 && length(g) == 0 && (println("Ошибка"); continue)

    tn = [findfirst(==(x), a) for x in t]
    gn = [findfirst(==(x), a) for x in g]

    r = [c =="ш" ?
        (tn[i] + gn[(i-1) % length(gn) + 1] - 1) % 33 + 1 :
        (tn[i] - gn[(i-1) % length(gn) + 1] +32) % 33 + 1
        for i in 1:length(tn)
    ]

    println("Result: $(join([a[n] for n in r]))")
end