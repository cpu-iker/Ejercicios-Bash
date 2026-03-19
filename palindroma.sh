#!/bin/bash
clear
# Función para validar que la palabra tiene 5 letras minúsculas
validar_palabra() {
    local palabra=$1
    # verifica longitud exacta de 5 caracteres
    if [[ ${#palabra} -ne 5 ]]; then
        echo "Error: La palabra debe tener exactamente 5 caracteres y en minúsculas."
        echo
	return 1
    fi
    # verifica que solo contenga letras minúsculas de la a hasta la z.
    if [[ ! "$palabra" =~ ^[a-z]{5}$ ]]; then
        echo "Error: Solo se permiten letras minúsculas, sin números ni caracteres especiales."
	echo
        return 1
    fi
    return 0
}

# Función para verificar si la palabra es palíndromo
es_palindromo() {
    local palabra=$1
    local rev=$(echo "$palabra" | rev)
    if [[ "$palabra" == "$rev" ]]; then
        return 0  # Devuelve 0 si efectivamente es palíndromo
    else
        return 1  # si no es palíndromo
    fi
}

# Mensaje de inicio con instrucciones.
echo "Introduce una palabra de 5 letras minúsculas para verificar si es palíndroma."
echo
echo "Para salir, escribe 'zzzzz'."
echo
echo "-----------------------------------"
echo

# Bucle controlado por la variable continuar
continuar=1
while [[ $continuar -eq 1 ]]; do
    read -p "Introduce la palabra: " palabra

    # Condición para salir del programa
    if [[ "$palabra" == "zzzzz" ]]; then
	clear
        echo
        echo "Saliendo del programa..."
        echo
        continuar=0
        continue
    fi

    # Validar la palabra usando la función
    validar_palabra "$palabra"
    if [[ $? -ne 0 ]]; then
        # si la validación falla, continuar con siguiente iteración
        continue
    fi

    # Comprobar si es palíndromo
    es_palindromo "$palabra"
    if [[ $? -eq 0 ]]; then
        echo "La palabra $palabra es un palíndromo."
        echo
    else
        echo "La palabra $palabra no es un palíndromo."
        echo
    fi
done

