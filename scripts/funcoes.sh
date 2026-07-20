#!/bin/bash

# Cria uma nova disciplina com sua estrutura de pastas
organizar_disciplinas() {

    # Limpa a tela
    clear

    # Cabeçalho
    echo "========================================="
    echo "      NOVA DISCIPLINA"
    echo "========================================="
    echo

    # Lê o nome da disciplina
    read -p "Digite o nome da disciplina: " disciplina

    # Verifica se o usuário digitou algum nome
    if [ -z "$disciplina" ]; then
        echo
        echo "❌ O nome da disciplina não pode estar vazio."
        read -p "Pressione ENTER..."
        return
    fi

    # Caminho onde a disciplina será criada
    pasta="disciplinas/$disciplina"

    # Verifica se ela já existe
    if [ -d "$pasta" ]; then

        echo
        echo "⚠️ Esta disciplina já existe."

    else

        # Cria as pastas da disciplina
        mkdir -p "$pasta"/{aulas,atividades,provas,trabalhos}

        # Cria um arquivo de anotações com informações iniciais
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

# Lista todas as disciplinas cadastradas
listar_disciplinas() {

    clear

    echo "========================================="
    echo "      DISCIPLINAS CADASTRADAS"
    echo "========================================="
    echo

    # Verifica se existe alguma disciplina
    if [ ! -d disciplinas ] || [ -z "$(ls -A disciplinas 2>/dev/null)" ]; then

        echo "Nenhuma disciplina cadastrada."

    else

        contador=1

        # Percorre todas as disciplinas
        for disciplina in disciplinas/*; do

            [ -d "$disciplina" ] || continue

            echo "$contador - $(basename "$disciplina")"

            contador=$((contador + 1))

        done

    fi

    echo
    read -p "Pressione ENTER para continuar..."
}

# Menu responsável pelas funções das disciplinas
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

        # Lê a opção escolhida
        read -p "Escolha: " op

        # Executa a função correspondente
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

# Organiza automaticamente os arquivos da pasta Downloads
organizar_downloads() {

    clear

    echo "========================================="
    echo "      ORGANIZADOR DE DOWNLOADS"
    echo "========================================="
    echo

    # Cria as pastas caso elas não existam
    mkdir -p downloads/PDF
    mkdir -p downloads/Imagens
    mkdir -p downloads/Videos
    mkdir -p downloads/Compactados

    # Move PDFs
    mv ~/Downloads/*.pdf downloads/PDF/ 2>/dev/null
    mv ~/Downloads/*.PDF downloads/PDF/ 2>/dev/null

    # Move imagens
    mv ~/Downloads/*.jpg downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.JPG downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.png downloads/Imagens/ 2>/dev/null
    mv ~/Downloads/*.PNG downloads/Imagens/ 2>/dev/null

    # Move vídeos
    mv ~/Downloads/*.mp4 downloads/Videos/ 2>/dev/null
    mv ~/Downloads/*.MP4 downloads/Videos/ 2>/dev/null

    # Move arquivos compactados
    mv ~/Downloads/*.zip downloads/Compactados/ 2>/dev/null
    mv ~/Downloads/*.ZIP downloads/Compactados/ 2>/dev/null

    echo "✅ Downloads organizados!"
    echo

    # Mostra quantos arquivos existem em cada pasta
    echo "Arquivos organizados:"
    echo "----------------------"

    echo "PDFs: $(find downloads/PDF -type f 2>/dev/null | wc -l)"
    echo "Imagens: $(find downloads/Imagens -type f 2>/dev/null | wc -l)"
    echo "Vídeos: $(find downloads/Videos -type f 2>/dev/null | wc -l)"
    echo "Compactados: $(find downloads/Compactados -type f 2>/dev/null | wc -l)"

    echo
}

# Procura um arquivo pelo nome
buscar_arquivos() {

    clear

    echo "======================================"
    echo "           BUSCAR ARQUIVOS"
    echo "======================================"

    echo

    # Lê o nome do arquivo
    read -p "Digite o nome do arquivo: " NOME

    echo

    # Procura o arquivo no projeto
    find . -iname "*$NOME*"

    echo
    read -p "Pressione ENTER para continuar..."
}

# Exibe algumas informações do sistema
info_sistema() {

    clear

    echo "======================================"
    echo "        INFORMACOES DO SISTEMA"
    echo "======================================"

    echo

    # Informações do computador
    echo "Usuario: $(whoami)"
    echo "Sistema: $(uname -s)"
    echo "Kernel : $(uname -r)"
    echo "Data   : $(date)"

    echo

    # Mostra o espaço disponível em disco
    echo "Espaco em disco:"
    df -h . | tail -1

    echo
    read -p "Pressione ENTER para continuar..."
}

# Remove uma disciplina
excluir_disciplina() {

    clear

    echo "========================================="
    echo "       EXCLUIR DISCIPLINA"
    echo "========================================="
    echo

    # Lista as disciplinas existentes
    ls disciplinas

    echo

    # Lê a disciplina que será apagada
    read -p "Digite o nome da disciplina: " disciplina

    # Verifica se ela existe
    if [ -d "disciplinas/$disciplina" ]; then

        # Remove a pasta da disciplina
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

# Permite acessar uma disciplina e visualizar sua estrutura
acessar_disciplina() {

    clear

    echo "========================================"
    echo "        ACESSAR DISCIPLINA"
    echo "========================================"
    echo

    # Guarda todas as disciplinas em um vetor
    mapfile -t disciplinas < <(ls -1 "./disciplinas")

    # Exibe as disciplinas numeradas
    for i in "${!disciplinas[@]}"; do
        echo "$((i+1)) - ${disciplinas[$i]}"
    done

    echo

    # Lê o número escolhido
    read -p "Digite o número da disciplina: " num

    # Verifica se o número é válido
    if ! [[ "$num" =~ ^[0-9]+$ ]] || [ "$num" -lt 1 ] || [ "$num" -gt "${#disciplinas[@]}" ]; then
        echo "Opção inválida."
        read -p "ENTER para continuar..."
        return
    fi

    # Seleciona a disciplina correspondente
    DISC="${disciplinas[$((num-1))]}"

    clear

    echo "========================================"
    echo "DISCIPLINA: $DISC"
    echo "========================================"
    echo

    # Mostra a estrutura da disciplina
    tree "./disciplinas/$DISC"

    echo
    read -p "ENTER para continuar..."
}