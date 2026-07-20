#!/bin/bash
# Importa todas as funções que estão no arquivo funcoes.sh
source scripts/funcoes.sh

# Mantém o menu principal rodando até o usuário escolher sair
while true
do
    # Limpa a tela antes de mostrar o menu
    clear

    # Cabeçalho do sistema
    echo "========================================="
    echo "              UNIHELPER"
    echo "========================================="
    echo
    echo "Usuário: $USER" # Mostra o usuário logado
    echo "Data: $(date '+%d/%m/%Y %H:%M')" # Mostra a data e hora atuais
    echo
    echo "========================================="
    echo # Opções do menu principal
    echo "1 📚 Organizar disciplinas"
    echo "2 📂 Organizar Downloads"
    echo "3 🔎 Buscar arquivos"
    echo "4 💻 Informações do sistema"
    echo "5 🚪 Sair"
    echo

    # Lê a opção escolhida pelo usuário
    read -p "Escolha uma opção: " opcao

    # Verifica qual opção foi escolhida
    case $opcao in

        1) # Abre o submenu de disciplinas
            menu_disciplinas 
            ;;

        2) # Organiza os arquivos da pasta Downloads
            organizar_downloads
            ;;

        3) # Procura arquivos dentro do projeto
            buscar_arquivos
            ;;

        4) # Exibe informações do computador
            info_sistema
            ;;

        5) # Encerra o programa
            echo
            echo "Obrigado por utilizar o UniHelper!"
            break
            ;;

        *) # Caso o usuário digite uma opção inexistente
            echo
            echo "Opção inválida!"
            ;;
    esac

    # Aguarda o usuário pressionar ENTER para voltar ao menu
    echo
    read -p "Pressione ENTER para voltar ao menu..."

done