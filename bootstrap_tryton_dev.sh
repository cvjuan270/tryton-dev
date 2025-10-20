#!/usr/bin/env bash

if [ -f .env ]; then
  source .env
  echo 'Variables  cargadas desde .env'
else
  echo 'ERROR: El archivo .env no se encontro'
  exit 1
fi

MODULES_PATH="$HOME/.pyenv/versions/$PYTHON_VERSION/envs/$ENV_NAME/lib/python${PYTHON_VERSION:0:3}/site-packages/trytond/modules/"

if ! command -v pyenv &>/dev/null; then
  echo 'pyenv NO esta instalado .. Iniciando la instalación'
  curl https://pyenv.run | bash
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.bashrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.bashrc
  echo 'eval "$(pyenv init -)"' >>~/.bashrc
  source ~/.bashrc
else
  echo 'pyenv ya está instalado: $(command -v pyenv)'
fi

# virtualenv
if pyenv versions | grep -q "$ENV_NAME"; then

  echo "El entorno virtual '$ENV_NAME' ya existe. Activando..."
  # Establecer localmente el entorno (ideal para scripts en el directorio del proyecto)
  pyenv local "$ENV_NAME"
  echo "¡Listo! Ahora usando: $(pyenv version)"

else

  echo "El entorno virtual '$ENV_NAME' NO existe. Creándolo..."

  # 1. Asegurarse de que la versión base esté instalada
  if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    echo "Instalando la versión base de Python $PYTHON_VERSION..."
    pyenv install "$PYTHON_VERSION"
  fi

  # 2. Crear el entorno virtual
  pyenv virtualenv "$PYTHON_VERSION" "$ENV_NAME"

  # 3. Establecer el entorno localmente
  pyenv local "$ENV_NAME"
  echo "¡El entorno ha sido creado, configurado y activado localmente!"
  echo "Ahora usando: $(pyenv version)"

fi

# Install gnuhealth all modules
python -m pip install --upgrade pip
pip install gnuhealth-all-modules==5
pip install cookiecutter==2.6.0
pip install debugpy

# create trytond.conf
cat >trytond.conf <<EOF
[web]
listen = [::]:$TRYTOND_PORT
root = /home/$USER/work/tryton-dev/package/
[database]
uri = postgresql://$PGPASSWORD:$PGUSER@$PGHOST:$PGPORT/
path = /home/$USER/work/tryton-dev/attach/
modules_path = $MODULES_PATH
EOF

# Modules dir
mkdir custom-addons
