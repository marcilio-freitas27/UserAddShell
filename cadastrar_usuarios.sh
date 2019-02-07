#!/bin/bash

echo " ------Cadastro de novos usuários-------"

# cadastro do usuário
echo -e "\nDeseja cadastrar um usuário(sim/não)?"
read escolha

	array=("sim" "não")
	# loop para criação de mais de um usuário
	while [ $escolha = "${array[0]}"  -a  $escolha != "${array[1]}" ]
	do

		if [ $escolha = "${array[0]}" ]
		then
			# escolha do nome de usuário
			echo -e "\nDigite o nome do novo usuário: "
			read nome

			# criando o usuário com o nome escolhido
			sudo useradd $nome

			# atribuindo/alterando uma senha para o novo usuário

			echo -e "\nDigite a senha do usuáirio(2 vezes): "
			sudo passwd $nome

			# criando umas pasta no diretório /home com o nome do usuário criado
                	sudo cp -r /etc/skel /home/$nome
			# adicionando permissões para o usuário na pasta home
			sudo chown -R $nome:$nome /home/$nome

			echo -e "\nUsuário $nome criado. Uma senha e uma pasta também foram atribuidas a esse usuário."

			# alterando shell padrão do usuário
			read -p "Você deseja alterar o seu shell?(sim/não)" opcao

			# condição parar alterar o shell

			if [ $opcao = "sim" ];
			then

				# mostra quais os tipos de shell que estão disponíveis
				echo -e "\nEscolha entre as opções abaixo: "
				cat /etc/shells
				sudo chsh $nome

				echo -e "\nSeu novo shell é:"
				cat /etc/passwd |grep $nome
			else
				echo -e "\nAté mais!"
			fi

			# adicionando o usuário ao grupo sudo
			echo -e "\nDeseja adicionar seu usuário ao grupo sudo? "
			read usuario

			if [ $usuario = "sim" ]
			then
				sudo usermod -aG sudo $nome
			fi

			echo -e "\nUsuário $nome adicionado ao grupo sudo."

			# estando dentro do loop (while) é possível criar mais usuários
			echo -e "\nDeseja cadastrar outro usuário(sim/não)?"
        		read escolha

		elif [ $escolha = "${array[1]}" ]
		then
			echo "Acabou!"
		else
			echo "valor inválido!"
		fi
done
echo "Fim do cadastro. Aproveite o terminal ;D"
