Funcion fecha_devolucion(dia, mes, anio, cantidad_dias_fuera)
	//Hace la suma de los dias a la fecha actual, en forma manual no encontre funciones que sumen dias en PSEINT
	dia_nuevo <- (dia + cantidad_dias_fuera)
	mes_nuevo <- mes
	anio_nuevo <- anio
	Si dia_nuevo > 31 Entonces
		Si (mes = 1 o mes = 3 o mes = 5 o mes = 7 o mes = 8 o mes = 10 o mes = 12) Entonces
			dia_nuevo = dia_nuevo - 31
		SiNo
			Si mes = 2 Entonces
				Si (anio Mod 4) = 0
					dia_nuevo = dia_nuevo - 29
				SiNo
					dia_nuevo = dia_nuevo - 28
				FinSi
			SiNo
				dia_nuevo = dia_nuevo - 30
			FinSi
		FinSi
		mes_nuevo = mes_nuevo + 1
	FinSi
	Si mes_nuevo = 13
		mes_nuevo <- 1
		anio_nuevo = anio_nuevo + 1
	FinSi
	// Fecha Devolucion seria dia_nuevo/mes_nuevo/anio
	Escribir "Debe Devolver el Titulo:", dia_nuevo, "/", mes_nuevo, "/", anio_nuevo
FinFuncion

Algoritmo libreria_gamel
	//Debido a que el Lenguaje Pseint no permite tipos de atos diferentes en un mismo Array
	//Se crearon 2 y tampoco encontre un claro manejo de fechas, solo que se puede dividir
	//En dia, mes y año, entonces guardo la fecha en 3 casilleros del Array
	//El Array titulo _libro (Guarda en la Columna 1 el Titulo, en la columna 2 Quien retiro)
	//El Array estado_libro (Guarda Columna 1 Cantidad de Dias que Sale (Si es 0 Siginifica que esta Disponible Caso Contrario Entregado)
	//								Columna 2 Dia Actual que se Entrego
	//								Columna 3 Mes Actual que se Entrego
	//								Columna 4 Año Actual que se Entrego
	dimension titulo_libro(10,2)
	dimension estado_libro(10,4)
	//Retorna un solo nro entero en formato AAAAMMDD
	//Ejemplo tomado de Pseint
	//Limite de 10 Titulos 
	fecha_actual <- FechaActual()
	anio_actual <- trunc(fecha_actual/10000)
	mes_actual <- trunc(fecha_actual/100)%100
	dia_actual <- fecha_actual%100
	
	titulo_libro(1,1) <- "El Poder de las Palabras"
	titulo_libro(1,2) <- ""
	titulo_libro(2,1) <- "Cien años de Soledad"
	titulo_libro(2,2) <- ""
	titulo_libro(3,1) <- "Ucrania"
	titulo_libro(3,2) <- ""
	titulo_libro(4,1) <- "La Revolucion de la Glucosa"
	titulo_libro(4,2) <- ""
	titulo_libro(5,1) <- "Que sea Mutuo o no sea Nada"
	titulo_libro(5,2) <- ""
	titulo_libro(6,1) <- "Sapiens"
	titulo_libro(6,2) <- ""
	titulo_libro(7,1) <- "La Tia Cosima"
	titulo_libro(7,2) <- ""
	// Inicializar el Array de estado a cero
	Para fila_inicial <- 1 Hasta 10 Hacer
		Para columna_inicial <- 1 Hasta 4 Hacer
			estado_libro(fila_inicial,columna_inicial) <- 0
		Fin Para
	Fin Para
	
	//Presentar el Menu Principal
	menu_principal <- 1
	//Indica el proximo lugar libre del Array para poder Agregar Libros el Limite es 10
	fila_libro <- 8
	
	Mientras menu_principal <> 0 Hacer
		Borrar Pantalla
		Escribir "      Menu Principal del Sistema"
		Escribir "Presione el numero de la Opcion Elegida"
		Escribir ""
		Escribir " 1 = Agregar un Nuevo Titulo"
		Escribir " 2 = Entregar Titulos Disponibles (Sale)"
		Escribir " 3 = Listar Titulos Entregados"
		Escribir " 4 = Ver Detalle de Titulos Entregados"
		Escribir " 5 = Devolver Titulos (Reingresa)"
		Escribir " 0 = Sale del Sistema"
		//Queria Agregar una Opcion de Titulos Vencidos pero como no podemnos guardar los datos en archivos
		//No tendria ningun sentido.
		Leer menu_principal
		Segun menu_principal Hacer
			1: //Agregar Nuevo Titulo (Libro)
				Borrar Pantalla
				Si fila_libro > 10 Entonces
					Escribir "*****************************************"
					Escribir "  SE ALCANZO EL MAXIMO NUMERO DE LIBROS  "
					Escribir "    NO SE PUEDEN INGRESAR MAS TITULOS    "
					Escribir "*****************************************"
					Escribir "Presiones cualquier tecla para continuar, Para Volver al Menu."
					Esperar Tecla
				Sino	
					Escribir "Ingrese los datos del Nuevo Libro"
					Escribir "================================="
					Escribir ""
					Escribir "Nombre de Libro:"
					Leer titulo_libro(fila_libro,1)
					Si titulo_libro(fila_libro,1) <> "" Entonces
						fila_libro = fila_libro + 1
						Escribir "Titulo:", titulo_libro(fila_libro,1), "AGREGADO CORRECTAMENTE"
						Escribir "Presiones cualquier tecla para continuar, Para Volver al Menu."
						Esperar Tecla
					FinSi
				FinSi
			2: //Listar Titulos Disponibles
				Borrar Pantalla
				Escribir "Listado de Titulos Disponibles Para Ser Entregados"
				Escribir "=================================================="
				Para fila_inicial <- 1 Hasta 10 Hacer
					Si estado_libro(fila_inicial,1) = 0 y titulo_libro(fila_inicial,1) <> "" Entonces
						Escribir fila_inicial, " ", titulo_libro(fila_inicial,1)
					FinSi
				Fin Para
				//Validar el valor leido contra estado_libro(seleccion,1) = 0 Caso Contrario selecciono un valor
				//fuera del rango o de un titulo no disponible Ojo con el valor maximo 10 para que el programa
				//no de error fuera de indice. Esta evaluacion se hace primero
				Escribir "Seleccione el numero de renglon del tiulo a Entregar o La tecla ENTER Para Volver al Menu"
				Leer titulo_seleccionado
				Si titulo_seleccionado >= 1 y titulo_seleccionado <= 10 Entonces
					Si estado_libro(titulo_seleccionado,1) > 0 Entonces
						Escribir "El numero de Renglo Ingresado no pertenece a un Titulo Disponible"
					SiNo
						Escribir "Titulo Seleccionado para ser Entregado:", titulo_libro(titulo_seleccionado,1)
						Escribir "Ingrese Nombre del Destinatario o La tecla ENTER Para Volver al Menu"
						Leer nombre_destinarario
						Si nombre_destinarario <> ""
							Escribir "Ingrese Cantidad de Dias Fuera de la Biblioteca"
							Leer cantidad_dias_fuera
							Si cantidad_dias_fuera > 0
								estado_libro(titulo_seleccionado,1) <- cantidad_dias_fuera
								estado_libro(titulo_seleccionado,2) <- dia_actual
								estado_libro(titulo_seleccionado,3) <- mes_actual
								estado_libro(titulo_seleccionado,4) <- anio_actual
								titulo_libro(titulo_seleccionado,2) <- nombre_destinarario
								Escribir "Titulo:", titulo_libro(titulo_seleccionado,1), " Entregado por:", cantidad_dias_fuera, " Dias A:", titulo_libro(titulo_seleccionado,2)
								Escribir "FUE ENTREGADO Y REGISTRADO CORRECTAMENTE"
								Escribir "Presiones cualquier tecla para volver al Menu Principal."
								Esperar Tecla
							FinSi
						FinSi
					FinSi
				FinSi
			3: // Listar Titulos Entregados
				Borrar Pantalla
				Escribir "          Listado de Titulos Entregados           "
				Escribir "=================================================="
				titulos_entregados <- 0
				Para fila_inicial <- 1 Hasta 10 Hacer
					Si estado_libro(fila_inicial,1) > 0 y titulo_libro(fila_inicial,1) <> "" Entonces
						Escribir titulo_libro(fila_inicial,1), " Fuera de la Biblioteca"
						titulos_entregados = titulos_entregados + 1
					FinSi
				Fin Para
				Si titulos_entregados > 0 Entonces
					Escribir "Cantidad de Titulo Entregados:", titulos_entregados
				SiNo
					Escribir "ACTUALMENTE NO EXISTE NINGUN TITULO ENTREGADO"
				FinSi
				Escribir "Presiones cualquier tecla para volver al Menu Principal."
				Esperar Tecla
			4: // Ver Detalles de Titulos Entregados Igual a lo Anterior pero con mas datos, se podria haber colocado junto
				Borrar Pantalla
				Escribir "     Listado de Titulos Entregados, Detallado     "
				Escribir "=================================================="
				titulos_entregados <- 0
				Para fila_inicial <- 1 Hasta 10 Hacer
					Si estado_libro(fila_inicial,1) > 0 y titulo_libro(fila_inicial,1) <> "" Entonces
						Escribir titulo_libro(fila_inicial,1), " Entregado a:", titulo_libro(fila_inicial,2), " Por:", estado_libro(fila_inicial,1), " Dias"
						fecha_devolucion(dia_actual, mes_actual, anio_actual, estado_libro(fila_inicial,1))
						titulos_entregados = titulos_entregados + 1
					FinSi
				Fin Para
				Si titulos_entregados > 0 Entonces
					Escribir "Cantidad de Titulo Entregados:", titulos_entregados
				SiNo
					Escribir "ACTUALMENTE NO EXISTE NINGUN TITULO ENTREGADO"
				FinSi
				Escribir "Presiones cualquier tecla para volver al Menu Principal."
				Esperar Tecla
			5: //Reingresar Devuelven un titulo_libro
				Borrar Pantalla
				Escribir "  Listado de Titulos Entregados, Para Reingresar  "
				Escribir "=================================================="
				titulos_entregados <- 0
				Para fila_inicial <- 1 Hasta 10 Hacer
					Si estado_libro(fila_inicial,1) > 0 y titulo_libro(fila_inicial,1) <> "" Entonces
						Escribir fila_inicial, " ", titulo_libro(fila_inicial,1), " Entregado a:", titulo_libro(fila_inicial,2), " Por:", estado_libro(fila_inicial,1), " Dias"
						titulos_entregados = titulos_entregados + 1
					FinSi
				Fin Para
				Si titulos_entregados > 0 Entonces
					Escribir "Seleccione el numero de renglon del tiulo a Reingresar o La tecla ENTER Para Volver al Menu"
					Leer titulo_seleccionado
					Escribir "Titulo Seleccionado para Reingresar:", titulo_libro(titulo_seleccionado,1)
					Escribir " 1 = Confirma Reingreso - 2 = Cancela y Vuelve al Menu"
					Leer confirma_reingreso
					Segun confirma_reingreso Hacer
						1:
							estado_libro(titulo_seleccionado,1) <- 0
							estado_libro(titulo_seleccionado,2) <- 0
							estado_libro(titulo_seleccionado,3) <- 0
							estado_libro(titulo_seleccionado,4) <- 0
							titulo_libro(titulo_seleccionado,2) <- ""
							Escribir "Titulo:", titulo_libro(titulo_seleccionado,1), " REINGRESO CORRECTAMENTE"
							Escribir "Presiones cualquier tecla para volver al Menu Principal."
							Esperar Tecla
						2:
							Escribir "CANCELO EL REINGRESO, Presiones cualquier tecla para volver al Menu Principal."
							Esperar Tecla
						De Otro Modo:
							Escribir "Opcion Incorrecta"
							Escribir "Presiones cualquier tecla para volver al Menu Principal."
							Esperar Tecla
					Fin Segun
				SiNo
					Escribir "NO EXISTEN NINGUN TITULO PARA REINGRESAR"
				FinSi
				
			De Otro Modo:
				Escribir "Selecciono una Opcion (Numero) no listado en el Menu"
		Fin Segun
	Fin Mientras
FinAlgoritmo