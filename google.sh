#!/bin/zsh

# Función Principal de Bash + Google Apps Script
google() {

  # Verificar si hay un argumentos
  if [[ -z "$1" ]]; then
    echo 'Error: No se ha especificado ninguna opción. Opciones Disponibles:'
    echo 'google ct: Crea una Cotización Automátizada en Google Docs con Descarga en PDF'
    return 1
  fi

  case "$1" in

    ct)

	    # Verificar si se han proporcionado todos los argumentos necesarios
      if [[ $# -lt 6 ]]; then
        echo "Error: Faltan argumentos."
        echo "Uso: ./google.sh ct <RUT> <SKU> <CANTIDAD> <SOLICITANTE> <CORREO> <ACCION>"
        return 1
      fi

      # Asignación de variables a partir de los argumentos
      RUT="$2"
      SKU="$3"
      CANTIDAD="$4"
      SOLICITANTE="$5"
      CORREO="$6"
      ACCION="$7"

      # Enviar los datos como JSON mediante POST al endpoint Macro de Google Apps Script ( El que estamos creando en la función doPost() del Script de Google )
      # Recuerda que del URL de Script de Google debemos cambiarlo. Se debe agregar el ID de GoogleScript.
      response=$(http --body --follow POST https:// \
      RUT="$RUT" SKU="$SKU" CANTIDAD="$CANTIDAD" SOLICITANTE="$SOLICITANTE" CORREO="$CORREO" ACCION="$ACCION")

      # Mostramos la Respuesta que programaremos en Google Apps Script
      echo $response | jq

      ;;

    *)

      # Validación + Ejemplo de Ejecución
      echo 'Opción No Válida'
      echo 'Opciones Disponibles:'
      echo 'Cotización: google ct 76775128-1 SPPE001 x8 "Maximiliano Aravena Araya" info@americansoftware.us [--pdf | --email]'
      ;;

  esac
}

# Llamada a la función google con argumentos (si los hay)
google "$@"