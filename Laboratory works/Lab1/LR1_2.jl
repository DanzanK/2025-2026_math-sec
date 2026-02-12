# Лабораторная работа №1
# Шифры простой замены
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#2 Шифр Атбаш

function Atbash(message::AbstractString, alphabet::Vector{Char})
    n = length(alphabet)
    output  = IOBuffer()

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
        
        println("Result $operation: $output")
    end
end

main()