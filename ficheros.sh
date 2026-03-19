#!/bin/bash


LOGFILE="logs.txt" #En este fichero .txt se registrarán los logs.

#Función para registrar los logs, utilizando el comando de la fecha y hora pedido en el enunciado.
registrar_log() {
    echo "$(date +'%Y/%m/%d %H:%M:%S') - $1" >> "$LOGFILE"
}

#Función para crear un fichero nuevo y validar el input antes de crearlo.
fichero_nuevo() {
    read -p "Introduzca el nombre del nuevo fichero: " NOMBRE
    if [ -z "$NOMBRE" ]; then #Para avisar en caso de que se introduzca una cadena vacía. No crea nada.
        echo "Error: No se introdujo ningún nombre."
        registrar_log "Error al crear el fichero: nombre no introducido."
        return
    fi

    if [ -e "$NOMBRE" ]; then #If en caso de que se introduzca un fichero que ya existe
        echo "El fichero '$NOMBRE' ya existe."
        registrar_log "Intento de crear '$NOMBRE' sin éxito porque ya existía."
    else
        touch "$NOMBRE" 2>/dev/null #Se crea el fichero
        if [ $? -eq 0 ]; then
            clear
            echo "Fichero '$NOMBRE' creado correctamente."
            registrar_log "Fichero '$NOMBRE' creado correctamente."
        else #Else por si todo lo anterior salió mal, para avisar del error y registrarlo en los logs
            echo "Error al crear el fichero '$NOMBRE'."
            registrar_log "Error al crear el fichero '$NOMBRE'."
        fi
    fi
}

#Función para editar un fichero con nano. Si no existe se avisara al usuario.
editar_fichero() {
    read -p "Introduzca la ruta absoluta del fichero a editar: " RUTA #Aquí se pide la ruta con read y -p para almacenarlo en la variable RUTA.
    if [ ! -f "$RUTA" ]; then #Si la ruta dada no existe.
        echo "El fichero '$RUTA' no existe."
        registrar_log "Error: intento de editar '$RUTA' sin éxito porque no existe." #Registro del error que se envia a la función logs para que se almacene.
    else
        clear
        nano "$RUTA" #Caso contrario, se abre la ruta dada con nano y luego enviará a los logs, o bien que se editó el archivo sin problemas o que hubo un error.
        if [ $? -eq 0 ]; then
            registrar_log "Fichero '$RUTA' editado correctamente."
        else
            registrar_log "Error al editar '$RUTA'."
        fi
    fi
}

#Función que mostraá el contenido del fichero de logs.
mostrar_logs() {
    clear
    echo "--- CONTENIDO DEL LOG ---"
    if [ -s "$LOGFILE" ]; then
        cat "$LOGFILE"
    else
        echo "No hay registros en el log."
    fi
    registrar_log "Se mostraron los logs." #Y se registra también en los logs que se accedió al fichero.
}

#Función para borrar un determinado fichero.
borrar_fichero() {
    read -p "Introduce la ruta absoluta del fichero a borrar: " RUTA
    if [ ! -f "$RUTA" ]; then #Si el fichero no existe.
        echo "El fichero '$RUTA' no existe."
        registrar_log "Error: intento de borrar '$RUTA' pero no existe."
        return
    fi

    read -p "¿Seguro que deseas borrar '$RUTA'? (s/n): " CONFIRMAR #Pide confirmación al usuario
    if [ "$CONFIRMAR" = "s" ] || [ "$CONFIRMAR" = "S" ]; then
        rm "$RUTA" 2>/dev/null
        if [ $? -eq 0 ]; then
            clear
            echo "Fichero '$RUTA' borrado correctamente." 
            registrar_log "Fichero '$RUTA' borrado correctamente." #Log si se borra bien.
        else
            echo "Error al borrar el fichero '$RUTA'."
            registrar_log "Error al borrar '$RUTA'." #Log si se borra mal.
        fi
    else
        echo "Operación cancelada."
        registrar_log "Cancelado el borrado de '$RUTA'." #Log si se cancela la eliminación.
    fi
}

#Función para salir del programa.
salir() {
    echo "Has elegido salir del programa."
    registrar_log "El usuario salió del programa."
    SALIR_PROGRAMA=1 #A través del control de esta variable se sale o no del programa.
}

#Menú del programa
mostrar_menu() {
    echo ""
    echo "--------- MENU ---------"
    echo "1) Fichero nuevo"
    echo "2) Editar fichero"
    echo "3) Mostrar logs"
    echo "4) Borrar fichero"
    echo "5) Salir"
    echo "------------------------"
}


SALIR_PROGRAMA=0 #Se pone la variable de control a 0 para empezar
until [ "$SALIR_PROGRAMA" -eq 1 ]; do #En el momento que sea igual a 1 el programa se acaba.
    mostrar_menu
    read -p "Elige una opción (1-5): " OPCION

    case $OPCION in #Condicional case que, dependiendo de que numero teclee el usuario llamará a la funcion que toque.
        1) fichero_nuevo ;;
        2) editar_fichero ;;
        3) mostrar_logs ;;
        4) borrar_fichero ;;
        5) salir ;;
        *)              #Si el usuario teclea cualquier cosa que no sea un numero del 1 al 5 le mostrará un error y lo registrará en los logs.
            echo "Opción no válida. Inténtelo de nuevo."
            registrar_log "Opción inválida seleccionada."
            ;;
    esac
done 