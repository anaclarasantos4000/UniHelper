#!/bin/bash
source scripts/funcoes.sh


while true
do

    clear

    echo "========================================="
    echo "              UNIHELPER"
    echo "========================================="
    echo
    echo "Usuário: $USER"
    echo "Data: $(date '+%d/%m/%Y %H:%M')"
    echo
    echo "========================================="
    echo
    echo "1 📚 Organizar disciplinas"
    echo "2 📂 Organizar Downloads"
    echo "3 🔎 Buscar arquivos"
    echo "4 💻 Informações do sistema"
    echo "5 🚪 Sair"
    echo

    read -p "Escolha uma opção: " opcao

    case $opcao in

        1)
            menu_disciplinas 
            ;;

        2)
            organizar_downloads
            ;;

        3)
            buscar_arquivos
            ;;

        4)
            info_sistema
            ;;

        5)
            echo
            echo "Obrigado por utilizar o UniHelper!"
            break
            ;;

        *)
            echo
            echo "Opção inválida!"
            ;;
    esac

    echo
    read -p "Pressione ENTER para voltar ao menu..."

done