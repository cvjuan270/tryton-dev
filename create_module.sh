#!/usr/bin/env bash

set -a # Exporta automáticamente las variables leídas
source .env
set +a # Deja de exportar automáticamente

# Obtener el directorio donde está el script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Variables configurables
MODULE_NAME=$1                                      # Nombre del módulo como argumento
DEST_DIR=${2:-"$HOME/work/tryton-dev/HDCO_HEALTH/"} # Directorio destino, por defecto el anterior
COOKIECUTTER_TEMPLATE="./common/tryton-branch-default/cookiecutter-module/"
MODULES_DIR="$VIRTUAL_ENV/lib/python${PYTHON_VERSION%.*}/site-packages/trytond/modules/"
CUSTOM_DIR=${2:-"$SCRIPT_DIR/custom-addons/"}

# Validar que se haya pasado el nombre del módulo
if [ -z "$MODULE_NAME" ]; then
  echo "Error: Debes proporcionar el nombre del módulo como argumento."
  echo "Uso: ./create_module.sh <nombre_del_modulo>"
  exit 1
fi

# Crear el módulo con cookiecutter
echo "Creando el módulo '$MODULE_NAME' con cookiecutter..."
# cookiecutter -o "$CUSTOM_DIR" "$COOKIECUTTER_TEMPLATE" --no-input module_name="$MODULE_NAME"
cookiecutter -o "$CUSTOM_DIR" "$COOKIECUTTER_TEMPLATE" module_name="$MODULE_NAME"

# Crear el enlace simbólico
MODULE_PATH="${CUSTOM_DIR}${MODULE_NAME}/"
SYMLINK_PATH="${MODULES_DIR}${MODULE_NAME}"

if [ -d "$MODULE_PATH" ]; then
  echo "Creando enlace simbólico para '$MODULE_NAME'..."
  ln -sfn "$MODULE_PATH" "$SYMLINK_PATH"
  echo "Enlace simbólico creado: $SYMLINK_PATH -> $MODULE_PATH"
else
  echo "Error: No se encontró el directorio del módulo en '$MODULE_PATH'."
  exit 1
fi

echo "¡Módulo '$MODULE_NAME' creado y enlazado correctamente!"

# cookiecutter -o ./custom/ ./custom/common/tryton-branch-default/cookiecutter-module/
# ln -s /home/juand/work/tryton-dev/custom/hdco_health_appointment_scheduling/ /home/juand/.pyenv/versions/3.10.13/envs/tryton_venv/lib/python3.10/site-packages/trytond/modules/hdco_health_appointment_scheduling
