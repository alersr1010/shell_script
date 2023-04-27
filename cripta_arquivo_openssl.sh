#!/bin/bash
selection=
chave=3
type=
re='^[A-Z ]+$'
ren='^[0-9]$'
menu='[a-zA-Z]+\.[a-z]+$'
texto=
nomeArq=
oldIFS=$IFS # mantém o separador de campo
IFS=$'n'
#=================================================================
function encript() {
  openssl enc -aes-256-cbc -e -pbkdf2 -nosalt -in "$nomeArq" -out "$criptNameArq" -pass pass:"$password" &>/dev/null
  exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    echo "Fail"
  else
    echo "Success"
    rm "$nomeArq"
  fi
}

function decript() {
  openssl enc -aes-256-cbc -d -pbkdf2 -nosalt -in "$nomeArq" -out "$criptNameArq" -pass pass:"$password" &>/dev/null
  exit_code=$?
  if [[ $exit_code -ne 0 ]]; then
    echo "Fail"
  else
    echo "Success"
    rm "$nomeArq"
  fi
}
#=================================================================
function lerArquivo(){
  echo "Enter the filename:"
  read nomeArq
  if [ -e "$nomeArq" ] ; then
    echo "File content:"
    cat  "$nomeArq"
    echo ""
  else
    echo "File not found!"
  fi

}
#=================================================================
function criaArquivo() {
  echo "Enter the filename:"
  read nomeArq
  if [[ "$nomeArq" =~ $menu ]] ; then
    echo "Enter a message:"
    read texto
    if [[ "$texto" =~ $re ]]; then
      echo $texto >$nomeArq
      echo "The file was created successfully!"
    else
      echo "This is not a valid message!"
    fi
  else
    echo "File name can contain letters and dots only!"
  fi

}
#=====================================================================
function criptArq(){
  echo "Enter the filename:"
  read nomeArq
  if [ -e "$nomeArq" ] ; then
    criptNameArq="$nomeArq"".enc"
    touch "$criptNameArq"
    echo "Enter password:"
    read password
    encript
  else
    echo "File not found!"
  fi
}
#===================================================================
function decriptArq(){
  echo "Enter the filename:"
  read nomeArq
  if [ -e "$nomeArq" ] ; then
    X='.enc'
    criptNameArq=${nomeArq%$X}
    touch "$criptNameArq"
    echo "Enter password:"
    read password
    decript
  else
    echo "File not found!"
  fi
}
#===================================================================
function executa() {
            case $selection in
            1 )  criaArquivo  ;;
            2 )  lerArquivo ;;
            3 )  criptArq ;;
            4 )  decriptArq ;;
            0 )  echo "See you later!"
                 exit ;;
            * ) echo "Invalid option!"
            esac
    echo ""
}



echo "Welcome to the Enigma!"
until [ "$selection" = "0"  ]; do
  echo "0. Exit"
  echo "1. Create a file"
  echo "2. Read a file"
  echo "3. Encrypt a file"
  echo "4. Decrypt a file"
  echo "Enter an option:"
  read selection
  executa
done
