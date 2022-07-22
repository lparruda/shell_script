#!/usr/bin/env bash
#---------------------------VARIÁVEIS------------------------------------------------------------------
ARQUIVO=stupid_db.cf
SEP=":"
TMP=$$
#---------------------------TESTE--------------------------------------------------------------------

#---------------------------FUNÇÃO---------------------------------------------------------------------
MostraLista(){
 egrep -i -v "^#|^$|sort" "$ARQUIVO"|sort |tr : " " > "$TMP"
dialog --title "Lista de Usuários" --textbox "$TMP" 20 40
rm -f "$TMP"

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
