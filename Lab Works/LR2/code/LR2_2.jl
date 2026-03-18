# Лабораторная работа №2
# Шифры перестановки
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#2 шифрование с помощью решеток

function cellbased_main()
    while true
        println("ш - шифрование, р - расшифровка, в - выход")
        
        cmd = lowercase(strip(readline()))
        cmd == "в" && (println("выход");
        break)

        cmd in ["ш","р"] || (println("Ошибка команды"); continue)
        print("Введите сообщение:")
        # Запрашиваем текст для шифрования/расшифрования и пароля шифра
        
        text = readline()
        # должен содержать 4 символа для решетки 2x2
        print("Введите пароль (4 символа):")
        password = readline()


        clean_chars = collect(replace(uppercase(text), " " => ""))
        pass_chars = collect(uppercase(password))

        k = 2 # размер решетки
        # Размер большой решетки (2k × 2k = 4x4)
        size_2k = 2k
        # Создаем булеву маску (false - закрыто, true - прорезь)
        grille = falses(size_2k, size_2k)
        # Заполняем маску прорезями в 4 угловых квадратах 2x2
        for i in 1:k, j in 1:k
            grille[i,j] = grille[i,k+j] = grille[k+i,j]  = grille[k+i,k+j] = true
        end

        total = size_2k^2

        length(clean_chars) < total && append!(clean_chars, fill('А', total - length(clean_chars)))
        table, idx, mask = fill(' ', size_2k, size_2k), 1, copy(grille)

        for _ in 1:4
            for i in 1:size_2k, j in 1:size_2k
                mask[i,j] && idx <= length(clean_chars) && (table[i,j] = clean_chars[idx]; idx += 1)
            end
            mask = reverse(mask,dims=1)
        end

        sorted_cols = sort(1:length(pass_chars), by = i ->pass_chars[i])
        result = join([table[i,j] for j in sorted_cols for i in 1:size_2k])

        println("Result: $result")
    end
end

cellbased_main()