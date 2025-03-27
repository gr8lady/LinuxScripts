#!/bin/bash

set -e

echo "🚀 Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando libvirt y herramientas de virtualización..."
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst

echo "👤 Agregando tu usuario al grupo libvirt..."
sudo usermod -aG libvirt $(whoami)

echo "🛜 Habilitando y levantando el servicio libvirtd..."
sudo systemctl enable --now libvirtd

echo "🔍 Verificando soporte para virtualización..."
if egrep -c '(vmx|svm)' /proc/cpuinfo | grep -q 0; then
    echo "❌ Tu CPU no soporta virtualización con KVM."
    exit 1
else
    echo "✅ Virtualización soportada."
fi

echo "📂 Creando carpeta para imágenes de VM (si no existe)..."
mkdir -p ~/VMs

echo "🧪 Probando libvirt con virsh..."
if virsh list --all >/dev/null 2>&1; then
    echo "✅ virsh funcionando correctamente."
else
    echo "⚠️ Algo salió mal con virsh. Verifica permisos."
fi

echo "🎉 ¡Todo listo, $(whoami)! Reinicia tu sesión o máquina para aplicar cambios del grupo 'libvirt'."
