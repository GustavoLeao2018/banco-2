from random import randint, randrange
from lorem import *

def hora():
	hora = randint(0, 23)
	if hora <= 9:
		hora = '0'+str(hora)

	minuto = randint(0, 59)
	if minuto <= 9:
		minuto = '0'+str(minuto)

	segundo = randint(0, 59)
	if segundo <= 9:
		segundo = '0'+str(segundo)

	return f'{hora}:{minuto}:{segundo}'

def data():
	ano  = randint(1900, 2100)
	mes = randint(1, 12)
	if mes == 2:
		dia = randint(1, 29)
	elif (mes % 2) != 0:
		dia = randint(1, 31)
	elif (mes % 2) == 0:
		dia = randint(1, 30) 		
	
	if mes <= 9:
		mes = '0'+str(mes)
	if dia <= 9:
		dia = '0'+str(dia)

	return f'{ano}-{mes}-{dia}'

def idAnimal():
	return randint(0, 100)

def idPessoa():
	return randint(0, 100)


def idConsulta():
	return randint(0, 100)

def obs():
	return sentence()

def gerar_cadastro():
	arquivo = open('inserir.sql', 'w')

	for i in range(randrange(30, 5500)):
		arquivo.write(f'''insert into Consulta (idanimal, idpessoa, hora, datacons, obs, idConsulta)
	values ({idAnimal()}, {idPessoa()}, '{hora()}', '{data()}', '{obs()}', '{idConsulta()}');
''')


	arquivo.close()

gerar_cadastro()