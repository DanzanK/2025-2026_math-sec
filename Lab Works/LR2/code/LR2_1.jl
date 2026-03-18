# Лабораторная работа №2
# Шифры перестановки
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#1 Маршрутное шифрование

function marshr_main()
    # Бесконечный цикл для работы программы до команды выхода

    while true
        # Выводим меню с доступными командами
        println("ш - шифрование, р - расшифровка, в - выход")
        #menu = lowercase(strip(readline()))
        cmd = lowercase(strip(readline()))
        cmd == "в" && (println("выход");
        break)
        cmd in ["ш","р"] || (println("Ошибка команды"); continue)
        # Запрашиваем текст для шифрования/расшифрования и пароля шифра
        print("Введите сообщение:")
        text = readline()
        print("Введите пароль :")
        password = readline()

        # подготовка текста
        # удаление пробелов и приводим к верхнему регистру
        clean_text = replace(uppercase(text), " " => "")
        # преобразуем пароль в массив символов (для избежания проблем с индексацией русских символов)
        pass_chars = collect(uppercase(password))
        # n - количество столбцов (равно длине пароля)
        # m - количество строк
        n, m = length(pass_chars), ceil(Int, length(clean_text) / length(pass_chars))

        padded = clean_text * "А"^(m*n - length(clean_text))
        table = reshape(collect(padded), (m, n))
        # создание таблицы
        column_pairs = [(pass_chars[i], i) for i in 1:length(pass_chars)]
        # Сортируем пары по символам пароля (алфавитный порядок)
        sort!(column_pairs, by = x -> x[1])
        sorted_cols = [idx for (char, idx) in column_pairs]
        result = join([table[i,j] for j in sorted_cols for i in 1:m])
        # вывод результата
        println("Result: $result")
    end
end

marshr_main()