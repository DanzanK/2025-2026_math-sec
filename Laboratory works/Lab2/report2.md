---
title: "Лабораторная работа №2"
subtitle: "Шифры перестановки: маршрутное шифрование, шифрование с помощью решёток, таблица Виженера"
author:
  - "Кюнкриков Даниил Саналович, НПИмд-01-24, 1132249574"
institute: "Российский университет дружбы народов (РУДН), Москва, Россия"
lang: ru-RU

format:
  pdf:
    toc: true
    toc-title: "Содержание"
    number-sections: true
    lof: true
    lot: true
    pdf-engine: xelatex
    papersize: a4
    mainfont: "Times New Roman"
    sansfont: "Arial"
    monofont: "Consolas"
    geometry: margin=2cm
    fontsize: 12pt
    fig-pos: "H"
    lst-pos: "H"
    include-in-header:
      text: |
        \usepackage{float}
        \KOMAoption{captions}{tableheading}
    documentclass: scrartcl
    classoption:
      - DIV=11
      - numbers=noendperiod
  docx:
    toc: true
    number-sections: true
---

# Введение

Шифры перестановки относятся к классическим методам криптографии, где **не заменяются** символы исходного текста, а меняется **их порядок**. 
В данной лабораторной работе реализованы три алгоритма: маршрутное шифрование (колоночная перестановка по ключевому слову), шифрование с помощью решёток и шифрование по таблице Виженера.

# Цель и задачи работы

**Цель:** реализовать шифры перестановки, заданные в работе: маршрутное шифрование, шифрование с помощью решёток, таблица Виженера.

**Задачи:**

1. Реализовать алгоритмы шифрования (и режим расшифровки через меню программы).
2. Проверить работу программ на тестовых сообщениях и ключах.
3. Оформить отчёт о проделанной работе.

# Теоретические сведения

## Маршрутное шифрование

Маршрутное (колоночное) шифрование реализуется через таблицу размером *m×n*, где *n* — длина ключевого слова (пароля). 
Текст записывается в таблицу, затем столбцы переставляются в соответствии с упорядочиванием букв ключа, после чего таблица считывается по столбцам.

## Шифрование с помощью решёток

Идея решётки (классический пример — решётка Кардано) заключается в том, что текст поэтапно записывается в “прорези” решётки, после поворотов/перестановок решётки заполняется вся таблица, а затем таблица считывается в заданном порядке. 

## Таблица Виженера

Шифр Виженера относится к полиалфавитным шифрам: для каждого символа сообщения используется сдвиг, определяемый текущим символом ключа. 
Ключ повторяется циклически, пока не достигнет длины сообщения.

# Реализация

Ниже приведены листинги программных реализаций (Julia).

## Маршрутное шифрование

Программная реализация Маршрутноого шифрования показана на [Листинге №1](#route).

### Листинг 1 — Маршрутное шифрование (колоночная перестановка){#route}

```julia
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
```


## Шифрование с помощью решёток

Программная реализация Шифрования с помощью решеток показана на [Листинге №2](#grille).


### Листинг 2 — Шифрование с помощью решёток{#grille}

```julia
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
```

## Таблица Виженера

Программная реализация таблицы Виженере показана на [Листинге №3](#vigenere).

### Листинг 3 — Таблица Виженера{#vigenere}

```julia
function vigenere()
    alphabet = collect("АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
    n = length(alphabet)

    while true
        println("ш - шифрование, р - расшифровка, в - выход")
        
        cmd = lowercase(strip(readline()))
        cmd == "в" && (println("выход"); break)

        cmd in ["ш","р"] || (println("Ошибка команды"); continue)
        print("Введите сообщение:")
        text = readline()
        print("Введите пароль :")
        password = readline()


        clean_chars = collect(replace(uppercase(text), " " => ""))
        pass_chars = collect(replace(uppercase(password), " " => ""))

        # Создаем пустой массив символов для ключа
        key_chars = Char[]
        # Для каждого символа текста определяем соответствующий символ ключа
        for i in 1:length(clean_chars)
            push!(key_chars, pass_chars[(i-1) % length(pass_chars) + 1])
        end

        result_chars = Char[]
        # Обрабатываем каждый символ текста
        for i in 1:length(clean_chars)
            text_char = clean_chars[i]
            key_char = key_chars[i]
            # Находим позиции символов в алфавите
            text_idx = findfirst(==(text_char), alphabet)
            key_idx = findfirst(==(key_char), alphabet)

            if text_idx !== nothing && key_idx !== nothing
                if cmd == "ш"
                    new_idx = (text_idx + key_idx - 1) % n
                    new_idx == 0 && (new_idx = n)
                else
                    new_idx = (text_idx + key_idx) % n
                    new_idx == 0 && (new_idx += n)
                end
                # Добавляем преобразованный символ к результату
                push!(result_chars, alphabet[new_idx])
            else
                push!(result_chars, text_char)
            end
        end
        result = String(result_chars)
       
        println("Result: $result")
    end
end

vigenere()
```

# Результаты работы

В качестве проверки были выполнены тестовые прогоны алгоритмов (пример ввода/вывода).

## Маршрутное шифрование — пример

Результат рограммной реализации маршрутного шифрования представлен на рисунке @fig-1

![Результат работы функции шифра маршрутного шифрования](images/image2.png){#fig-1 width=90%}

## Решётка 4×4 — пример

Результат программной реализации шифрования с помощью решеток представлен на рисунке @fig-2

![Результат работы функции шифрования по решетке 4x4](images/image4.png){#fig-2 width=90%}

## Виженер — пример


Результат программной реализации таблицы Виженере представлен на рисунке @fig-3

![Результат работы функции по таблицце Виженере](images/image7.png){#fig-3 width=90%}

# Выводы

В ходе лабораторной работы реализованы шифры перестановки: маршрутное шифрование, шифрование с помощью решёток, таблица Виженера, а также выполнены тестовые прогоны программ.


