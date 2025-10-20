# GNU Health + Tryton Dev Bootstrap

Este proyecto te ayuda a levantar un entorno de desarrollo para GNU Health sobre Tryton de manera rápida y sin dramas.

## 🚀 ¿Qué hace este repo?

- Prepara tu entorno Python con `pyenv` y `virtualenv`.
- Instala GNU Health y todos sus módulos.
- Genera el archivo de configuración `trytond.conf` listo para usar.
- Incluye un script para crear nuevos módulos con `cookiecutter` y enlazarlos automáticamente.

## 🛠️ Requisitos

- Linux (Ubuntu recomendado)
- `pyenv` y `pyenv-virtualenv` instalados
- Python 3.8+ (recomendado)
- Git
- Un archivo `.env` con tus variables (ver ejemplo abajo)

## ⚡ Instalación rápida

1. **Clona el repo:**
   ```sh
   git clone https://github.com/tuusuario/gnuhealth-tryton-bootstrap.git
   cd gnuhealth-tryton-bootstrap

2. **Crea tu archivo `.env`:**
```
PYTHON_VERSION=3.10.13
ENV_NAME=tryton_venv
TRYTON_DB=gh_dev
TRYTOND_PORT=8000
PGHOST=localhost
PGPORT=5432
PGUSER=user
PGPASSWORD=passuser
USER=user
ADDONS_PATH=src/custom
```
3. **Ejecuta el bootstrap:**
   ```sh
   bash bootstrap_tryton_dev.sh
   ```

4. **(Opcional) Crea un nuevo módulo:**
   ```sh
   bash create_module.sh nombre_del_modulo
   ```

## 🧩 ¿Qué scripts incluye?

- **bootstrap_tryton_dev.sh:**  
  Prepara todo el entorno, instala dependencias y genera la config.

- **create_module.sh:**  
  Crea un nuevo módulo Tryton usando cookiecutter y lo enlaza en tu entorno.

## 🏗️ Comandos útiles con Makefile

Este proyecto incluye un **Makefile** para facilitar tareas comunes en el desarrollo con Tryton/GNU Health.

### **Principales comandos**

- **Levantar el servidor Tryton:**
  ```sh
  make run
  ```
  > Inicia el servidor en modo desarrollo con logs detallados.

- **Actualizar todos los módulos:**
  ```sh
  make update
  ```
  > Aplica actualizaciones a todos los módulos instalados en la base de datos.

- **Actualizar/instalar un módulo específico:**
  ```sh
  make u_m M=nombre_del_modulo
  ```
  > Ejemplo para actualizar el módulo `gnuhealth`:
  ```sh
  make u_m M=gnuhealth
  ```
