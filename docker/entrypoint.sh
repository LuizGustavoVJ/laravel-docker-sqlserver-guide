#!/bin/bash
set -e

SA_PASSWORD='ABj!010359'
DB_NAME='teste_docker_laravel'
SQL_SERVER='laravel-sqlserver'

echo "Aguardando SQL Server iniciar..."

until /opt/mssql-tools/bin/sqlcmd -S $SQL_SERVER -U sa -P "$SA_PASSWORD" -Q "SELECT 1" 2>&1 | tee /dev/stderr | grep -q "1"
do
  echo "SQL Server não disponível ainda, esperando 2s..."
  sleep 2
done

echo "SQL Server está pronto!"

echo "Criando banco de dados '$DB_NAME' se não existir..."
/opt/mssql-tools/bin/sqlcmd -S $SQL_SERVER -U sa -P "$SA_PASSWORD" -Q "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '$DB_NAME') CREATE DATABASE [$DB_NAME]"

echo "Bancos disponíveis:"
/opt/mssql-tools/bin/sqlcmd -S $SQL_SERVER -U sa -P "$SA_PASSWORD" -Q "SELECT name FROM sys.databases"

# Aguarda o banco estar disponível
sleep 5

echo "Executando migrations Laravel..."

# Vai para o diretório onde está o Laravel (ajuste se necessário)
cd /var/www/html

# Força a execução das migrations (sem prompt interativo)
php artisan migrate --force

echo "Inicialização completa, iniciando PHP-FPM..."

exec php-fpm
