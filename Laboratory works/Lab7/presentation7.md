---
## Front matter
lang: ru-RU
title: Лабораторная работа №7
subtitle:  Дискретное логарифмирование в конечном виде
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

- Реализация p - метода Полларда для дискретного логарифмирования
- Изучение вероятностных методов в криптографии

## Объект и предмет исследования

- p - метода Полларда
- Задача дискретного логарифмирования в конечных полях
- Конечные поля и их алгебраические свойтсва
- Метод "черепахи и зайца" для поиска коллизий
- Язык программирования python

## Цели и задачи

- Реализовать p - метода Полларда для дискретного логарифмирования на языке программирования python
- Проанализировать поведение и эффективность алгоритма в зависимости от заданных параметров поля

### Задача дискретного логарифмирования (DLP)

Для заданных простого числа \( p \), основания  \( a \) (образующего элемента мультипликативной группы \( \mathbb{F}_p^* \)) и числа \( b \) требуется найти целое число \( x \), при котором

\[ 
a^x \equiv b \ (\text{mod} \ p)
\]

где \( 1 < a < p \), \( 1 < b < p \)

### Конечные поля

Множество классов вычетов по модулю простого числа \( p \) образует конечное поле \( \mathbb{F}_p = \mathbb{Z}/p\mathbb{Z} \), которое обладает следующими свойствами:
- Сложение и умножение определены по модулю \( p \)
- Существует мультипликативная группа \( \mathbb{F}_p^* \) порядка \( p-1 \)
- Каждый ненулевой элемент имеет обратный по умножению

# Процесс выполнения работы
## Реализация метода Полларда по разложению чисел на множители на языке python 


:::::::::::::: {.columns align=top}
::: {.column width="25%"}



<img width="559" height="770" alt="image" src="https://github.com/user-attachments/assets/e0802366-41dd-4f15-b03a-9fa2a7b1a56b" />





:::
::::::::::::::








# Результаты

- Успешно реализованы все задачи, поставленные для выполнения лабораторной работы 

:::::::::::::: {.columns align=top}
::: {.column width="25%"}



<img width="688" height="440" alt="image" src="https://github.com/user-attachments/assets/6bb42ff7-c888-421e-a48f-a1b070a8ceb0" />






:::
::::::::::::::

:::::::::::::: {.columns align=top}
::: {.column width="25%"}





<img width="572" height="314" alt="image" src="https://github.com/user-attachments/assets/85c5984e-87ae-4ba7-9fbc-c92f3cdf9dc2" />





:::
::::::::::::::



## Вывод

Реализован p-метод Полларда по дискретному логарифмированию в конечном поле на языке программирования python. Также вычислен логарифм на основе заданных параметрах конечного поля
