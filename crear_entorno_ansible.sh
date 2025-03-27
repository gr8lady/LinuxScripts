#!/bin/bash

set -e

# Nombre del entorno
ENV_NAME="venv"

echo "📁 Creando entorno virtual '$ENV_NAME'..."
python3 -m venv "$ENV_NAME"

echo "💻 Activando entorno..."
source "$ENV_NAME/bin/activate"

echo "📦 Instalando Ansible..."
pip install --upgrade pip
pip install ansible

echo "✅ Entorno listo. Ansible versión:"
ansible --version

echo "👉 Para activar el entorno en el futuro:"
echo "source $ENV_NAME/bin/activate"
