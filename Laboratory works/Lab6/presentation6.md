---
## Front matter
lang: ru-RU
title: Лабораторная работа №6
subtitle:  Разложение чисел на множители. Метод Полларда
author: Кюнкриков Д.С.
  - 
institute: Российский университет дружбы народов, Москва, Росиия
  - 
date:
- 

## i18n babel
babel-lang: russian
babel-otherlangs: english

## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9

## Formatting pdf
toc: false
toc-title: Содержание
slide_level: 2
aspectratio: 169
section-titles: true
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
 - '\makeatletter'
 - '\beamer@ignorenonframefalse'
 - '\makeatother'
---

# Информация

## Докладчик

:::::::::::::: {.columns align=center}
::: {.column width="70%"}

  * Кюнкриков Даниил Саналович
  * студент уч. группы НПИмд-01-24
  * Российский университет дружбы народов
  * 1132249574@pfur.ru
  * https://github.com/DanzanK/2025-2026_math-sec/tree/main


:::

::::::::::::::

# Вводная часть

## Актуальность

- Реализация p - метода Полларда для разложения чисел на множители

## Объект и предмет исследования

- p - метода Полларда
- Факторизация больших чисел
- Псевдослучайные последовательности
- Веб-сервис GitHub
- Язык разметки Markdown
- Язык программирования python

## Цели и задачи

- Реализовать p - метода Полларда на языке программирования python.
- Проанализировать поведение алгоритма на заданных числах

## Метод Полларда
- Вероятностный алгоритм для нахождения нетривиальных делителей
- Основан на поиске циклов в псевдослучяайной последовательности
- Использует "черепаху" и "зайца" для обнаружения делителей

## Алгоритм

1. Выбор псевдослучайной функции f(x) = (x^2 + c) mod n
2. 2.Инициализация a = b = 1
3. На каждом шаге итерации:
   - a = f(a) (step 1)
   - b = f(f(b)) (step 2)
   - d = НОД(|a - b|, n) (где НОД - Наибольший общий делитель)
4. Ессли 1 < d < n - найден нетривиальный делитель

# Процесс выполнения работы
## Реализация метода Полларда по разложению чисел на множителя используя язык программирования python 


:::::::::::::: {.columns align=top}
::: {.column width="25%"}



<img width="618" height="517" alt="image" src="https://github.com/user-attachments/assets/a665b5d2-1693-4d25-b00b-68d66bfb8e1e" />




:::
::::::::::::::








# Результаты

- Успешно реализованы все задачи, поставленные для выполнения лабораторной работы 

:::::::::::::: {.columns align=top}
::: {.column width="25%"}



<img width="619" height="472" alt="image" src="https://github.com/user-attachments/assets/679117a4-c395-4f1c-a7f2-b0e7bc4fdf74" />





:::
::::::::::::::





## Вывод

Реализован p-метод Полларда по на языке программирования python по разложению чисел на множители
