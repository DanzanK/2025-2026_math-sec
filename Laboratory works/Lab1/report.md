---
title: "Лабораторная работа №1"
format:
  html: 
    toc: true
    code-fold: true
    code-line-numbers: true
    code-tools: true

--- 

## Тема: Шифр простой замены

**Выполнил:** Кюнкриков Даниил Саналович, НПИмд-01-24, студ: 1132249574

---




## Шифр Цезаря

``` Julia

function main()
    # задаем алфавит для шифрования
    alphabet = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    n = length(alphabet)
    # создание меню с доступными командами (шифровка/расшифровка)
    while true
        println("ш - шифрование, р - расшифровка, в - выход")
        # чтение ввода пользователя
        menu = lowercase(strip(readline()))
        if menu == "в"
            break
        elseif menu == "ш"
            operation = "шифрование"
        elseif menu == "р"
            operation = "расшифровка"
        else
            println("Ошибка команды")
            continue
        end
        
        # Запрос строки для обработки и ключа шифрования
        print("Введите сообщение:")
        message = lowercase(strip(readline()))
        print("Введите ключ (число):")
        try
            key = parse(Int,readline())
        catch e
            println("Ошибка catch")
            continue
        end
        # инвертирование ключа при расшифровки
        if menu =="р"
            key = -key
        end
        output = ""
        
        # проходка по каждому сиволу входящего сообщения
        for letter in message
            # поиск текущего символа в алфавите
            idx = findfirst(isequal(letter), alphabet)
            #  вычисление позиции результирующего символа
            if idx !== nothing
                new_idx = mod(idx+key-1,n)+1
                output *= string(alphabet[new_idx])
            else 
                output *= string(letter)
            end
        end
        #  вывод результата
        println("Result $operation: $output")
    end
end
```

## Шифр Атбаш

``` Julia
# функция шифра Атбаш принимающая на вход алфавит и заданное сообщение
function Atbash(message::AbstractString, alphabet::Vector{Char})
    n = length(alphabet)
    output  = IOBuffer()

    #  поиск соответствующего символа в отзеркаленном алфавите и составление результирующего слова
    for letter in message
        idx = findfirst(==(letter), alphabet)
        if idx !== nothing
            new_idx = n - idx + 1
            write(output, alphabet[new_idx])
        else 
            write(output, letter)
        end
    end
    return String(take!(output))
end


function main()
    alphabet = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    while true
        println("ш - шифрование, р - расшифровка, в - выход")
        menu = lowercase(strip(readline()))
        if menu == "в"
            break
        elseif menu == "ш"
            operation = "шифрование"
        elseif menu == "р"
            operation = "расшифровка"
        else
            println("Ошибка команды")
            continue
        end

        print("Введите сообщение:")
        message = lowercase(strip(readline()))
        
        output = Atbash(message, alphabet)
        #  вывод результата
        println("Result $operation: $output")
    end
end
```
