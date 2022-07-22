#!/usr/bin/env bash
#---------------------------VARIÁVEIS------------------------------------------------------------------
ARQUIVO=stupid_db.cf
SEP=":"
TMP=$$
#---------------------------TESTE--------------------------------------------------------------------

#---------------------------FUNÇÃO---------------------------------------------------------------------
MostraLista(){
while read -r lista
do
	[ -z "$lista" ] && continue
	[ "$(echo $lista | cut -c1)" = "#" ] && continue
	MostrarUsuarios "$lista"
	done < "$ARQUIVO"
	}

	MostrarUsuarios(){
	local receba=$1
	ID="$(echo $receba |cut -d $SEP -f 1)"
	NOME="$(echo $receba |cut -d $SEP -f 2)"
	EMAIL="$(echo $receba |cut -d $SEP -f 3)"

	echo "ID: $ID"
	echo "NOME: $NOME"
	echo "EMAIL: $EMAIL"
	}

	ValidarUsuarios(){
	grep -i "$1$SEP" "$ARQUIVO"

	}

	InserirUsuario(){
		local receba="$(echo $1 |cut -d $SEP -f 2)"
		if ValidarUsuarios "$receba"
		then 
			echo "Usuário já existe."
		else
			echo  "$1" >> "$ARQUIVO"
		ValidarUsuarios
	fi

}

RemoverUsuario(){
 ValidarUsuarios "$1" || return
	
		grep -i -v "$1" "$ARQUIVO" > "$TMP"
		mv "$TMP" "$ARQUIVO" 
		ValidarUsuarios
	

}

OrdenaLista(){
grep -i "$1$SEP" "$ARQUIVO" |sort


}

#---------------------------EXECUÇÃO------------------------------------------------------------------
