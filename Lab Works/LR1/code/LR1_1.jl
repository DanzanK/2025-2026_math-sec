# Лабораторная работа №1
# Шифры простой замены
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#1 Шифр Цезаря

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

main()