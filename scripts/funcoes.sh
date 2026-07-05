#!/bin/bash

organizar_disciplinas() {

    clear

    echo "========================================="
    echo "      NOVA DISCIPLINA"
    echo "========================================="
    echo

    read -p "Digite o nome da disciplina: " disciplina

    if [ -z "$disciplina" ]; then
        echo
        echo "❌ O nome da disciplina não pode estar vazio."
        read -p "Pressione ENTER..."
        return
    fi

    pasta="disciplinas/$disciplina"

    if [ -d "$pasta" ]; then

        echo
        echo "⚠️ Esta disciplina já existe."

    else

        mkdir -p "$pasta"/{aulas,atividades,provas,trabalhos}

        cat > "$pasta/anotacoes.txt" <<EOF
=========================================
Disciplina: $disciplina
Criada em: $(date '+%d/%m/%Y %H:%M')
=========================================

Professor:

Sala:

Horário:

Observações:

EOF

        echo
        echo "✅ Disciplina criada com sucesso!"
        echo
        echo "Estrutura criada:"
        echo
        echo "📁 $disciplina"
        echo " ├── 📂 aulas"
        echo " ├── 📂 atividades"
        echo " ├── 📂 provas"
        echo " ├── 📂 trabalhos"
        echo " └── 📄 anotacoes.txt"

    fi

    echo
    read -p "Pressione ENTER para continuar..."
}
listar_disciplinas() {

    clear

    echo "========================================="
    echo "      DISCIPLINAS CADASTRADAS"
    echo "========================================="
    echo

    if [ ! -d disciplinas ] || [ -z "$(ls -A disciplinas 2>/dev/null)" ]; then

        echo "Nenhuma disciplina cadastrada."

    else

        contador=1

        for disciplina in disciplinas/*; do

            [ -d "$disciplina" ] || continue

            echo "$contador - $(basename "$disciplina")"

            contador=$((contador + 1))

        done

    fi

    echo
    read -p "Pressione ENTER para continuar..."
}


menu_disciplinas() {

    while true
    do

        clear

        echo "========================================="
        echo "      GERENCIAR DISCIPLINAS"
        echo "========================================="
        echo
        echo "1 📚 Criar nova disciplina"
        echo "2 📂 Acessar disciplina"
        echo "3 📋 Listar disciplinas"
        echo "4 🗑️ Excluir disciplina"
        echo "5 🔙 Voltar"
        echo

        read -p "Escolha: " op

        case $op in

            1) organizar_disciplinas ;;
            2) acessar_disciplina ;;
            3) listar_disciplinas ;;
            4) excluir_disciplina ;;
            5) break ;;

            *)

                echo "Opção inválida."
                sleep 1
                ;;

        esac

    done
}
organizar_downloads() {

    clear

    echo "========================================="
    echo "      ORGANIZADOR DE DOWNLOADS"
    echo "========================================="
    echo

    mkdir -p downloads/PDF
    mkdir -p downloads/Imagens
    mkdir -p downloads/Videos
    mkdir -p downloads/Compactados

    mv ~/Downloads/*.pdf downloads/PDF/ 2>/dev/null
    mv ~/Downloads/*.PDF downloads/PDF/ 2>/dev/null

    mv ~/Downloads/*.jpg downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.JPG downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.png downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.PNG downloads/Imagens/ 2>/dev/null

    mv ~/Downloads/*.mp4 downloads/Videos/ 2>/dev/null
    mv ~/Downloads/*.MP4 downloads/Videos/ 2>/dev/null

    mv ~/Downloads/*.zip downloads/Compactados/ 2>/dev/null
    mv ~/Downloads/*.ZIP downloads/Compactados/ 2>/dev/null

    echo "✅ Downloads organizados!"
    echo

    echo "Arquivos organizados:"
    echo "----------------------"

    echo "PDFs: $(find downloads/PDF -type f 2>/dev/null | wc -l)"
    echo "Imagens: $(find downloads/Imagens -type f 2>/dev/null | wc -l)"
    echo "Vídeos: $(find downloads/Videos -type f 2>/dev/null | wc -l)"
    echo "Compactados: $(find downloads/Compactados -type f 2>/dev/null | wc -l)"

    echo
}


buscar_arquivos() {
    clear
    echo "======================================"
    echo "           BUSCAR ARQUIVOS"
    echo "======================================"

    echo
    read -p "Digite o nome do arquivo: " NOME

    echo
    find . -iname "*$NOME*"

    echo
    read -p "Pressione ENTER para continuar..."
}

info_sistema() {
    clear
    echo "======================================"
    echo "        INFORMACOES DO SISTEMA"
    echo "======================================"

    echo
    echo "Usuario: $(whoami)"
    echo "Sistema: $(uname -s)"
    echo "Kernel : $(uname -r)"
    echo "Data   : $(date)"
    echo

    echo "Espaco em disco:"
    df -h . | tail -1

    echo
    read -p "Pressione ENTER para continuar..."
}
excluir_disciplina() {

    clear

    echo "========================================="
    echo "       EXCLUIR DISCIPLINA"
    echo "========================================="
    echo

    ls disciplinas

    echo
    read -p "Digite o nome da disciplina: " disciplina

    if [ -d "disciplinas/$disciplina" ]; then

        rm -rf "disciplinas/$disciplina"

        echo
        echo "✅ Disciplina removida com sucesso!"

    else

        echo
        echo "❌ Disciplina não encontrada."

    fi

    echo
    read -p "Pressione ENTER para continuar..."
}

acessar_disciplina() {
    clear

    echo "========================================"
    echo "        ACESSAR DISCIPLINA"
    echo "========================================"
    echo

    mapfile -t disciplinas < <(ls -1 "./disciplinas")

    for i in "${!disciplinas[@]}"; do
        echo "$((i+1)) - ${disciplinas[$i]}"
    done

    echo
    read -p "Digite o número da disciplina: " num

    if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt "${#disciplinas[@]}" ]; then
        echo "Opção inválida."
        read -p "ENTER para continuar..."
        return
    fi

    DISC="${disciplinas[$((num-1))]}"

    clear
    echo "========================================"
    echo "DISCIPLINA: $DISC"
    echo "========================================"
    echo

    tree "./disciplinas/$DISC"

    echo
    read -p "ENTER para continuar..."
}