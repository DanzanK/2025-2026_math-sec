# Лабораторная работа №2
# Шифры перестановки
# Кюнкриков Даниил, НПИмд-01-24, студ: 1132249574

#3 Таблица Виженера

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


        key_chars = Char[]
        for i in 1:length(clean_chars)
            push!(key_chars, pass_chars[(i-1) % length(pass_chars) + 1])
        end

        result_chars = Char[]
        for i in 1:length(clean_chars)
            text_char = clean_chars[i]
            key_char = key_chars[i]
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