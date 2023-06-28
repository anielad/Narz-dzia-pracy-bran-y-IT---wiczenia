#!/bin/bash

if [[ "$1" == "--date" || "$1" == "-d" ]]; then
    echo "$(date +%Y-%m-%d)"
    exit 0
elif [[ "$1" == "--logs" || "$1" == "-l" ]]; then
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
        num_files="$2"
    else
        num_files=100
    fi

    for ((i=1; i<=$num_files; i++)); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > "$filename"
        echo "Nazwa skryptu: $0" >> "$filename"
        echo "Data: $(date +%Y-%m-%d)" >> "$filename"
    done
    exit 0
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Dostępne opcje:"
    echo "--date (-d) : Wyświetla dzisiejszą datę."
    echo "--logs (-l) [liczba] : Tworzy automatycznie podaną liczbę plików logx.txt."
    echo "                       Domyślnie tworzy 100 plików."
    echo "--help (-h) : Wyświetla dostępne opcje."
    echo "--init : Klonuje repozytorium i ustawia ścieżkę w zmiennej środowiskowej PATH."
    echo "--error (-e) [liczba] : Tworzy podaną liczbę plików errorx/errorx.txt."
    exit 0
elif [[ "$1" == "--init" ]]; then
    git clone <https://github.com/anielad/Narz-dzia-pracy-bran-y-IT---wiczenia>
    export PATH="$PATH:$(pwd)"
    exit 0
elif [[ "$1" == "--error" || "$1" == "-e" ]]; then
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
        num_files="$2"
    else
        num_files=100
    fi

    mkdir -p errorx
    for ((i=1; i<=$num_files; i++)); do
        filename="errorx/error${i}.txt"
        echo "To jest plik błędu $i" > "$filename"
    done
    exit 0
fi
echo "*log*" > .gitignore

git tag v1.0


git add .gitignore
git commit -m "Dodanie .gitignore"
git push

git checkout głównyBranch
git merge taskBranch
