# Лабораторная работа №1
# Шифры простой замены
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#1 Шифр Цезаря

function main()
    alphabet = collect("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    n = length(alphabet)
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
        print("Введите ключ (число):")
        try
            key = parse(Int,readline())
        catch e
            println("Ошибка catch")
            continue
        end
        if menu =="р"
            key = -key
        end
        output = ""
        
        for letter in message
            idx = findfirst(isequal(letter), alphabet)
            if idx !== nothing
                new_idx = mod(idx+key-1,n)+1
                output *= string(alphabet[new_idx])
            else 
                output *= string(letter)
            end
        end
        println("Result $operation: $output")
    end
end

main()