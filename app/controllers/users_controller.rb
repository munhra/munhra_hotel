class UsersController < ApplicationController

	def show				
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user,
			notice: 'Cadastro atualizado com sucesso!'
		else
			render action: :edit
		end
	end

	def new
		# cria instancia do modelo usando o metodo new
		# neste caso @user é uma variável de instancia
		# o controller compartilha todas as variaveis
		# de instancia com o template ou seja toda variável
		# com @ está dispoível para ser usada na renderização
		@user = User.new 
	end

	def create
		
		#metodo params retorna um hash com todos os parametros
		#enviados pelo usuario, podemos acessar com chave
		#sendo string ou simbolo como abaixo 
		#HashWithIndifferentAccess, o new aceita um hash
		#com o conteudo a ser designado mass-assignement
		#proteção do mass-assignement
		@user = User.new(user_params)

		if @user.save
			Signup.confirm_email(@user).deliver
			#envia ao browser um 302 redirect, para um endereço 
			#que será retornado pelo metodo redirect_ro, redirencionando
			#para ação show com o id do objeto o primeiro parametro
			#é o objeto user e o segundo parametro é um flash
			#flash[:notice] = 'Cadastro criado ...', uma caractristica do 
			#flash é que ele é guardado na sessão do usuario
			redirect_to @user, notice: 'Cadastro criado com sucesso!'

		else
			#render não redirenciona o usuário para outra pagina
			#apenas usa o template, utilizando o render, não perdemos
			#as informações digitadas pelo usuário por isso é melhor
			#usar o render quando acontece algum erro na inserção
			render action: :new
		end
	end

	private 

	def user_params

		params. #esse ponto apenas quebra alinha
		require(:user).#verifica a presença da chave user
		permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
	
	end


end