# Resumo do Setup Docker Laravel + SQL Server com Migrations Automáticas

## 1. Dockerfile do app Laravel

- Usa PHP 8.2-fpm como base
- Instala dependências, ODBC Driver SQL Server, `msodbcsql18`, e ferramentas `mssql-tools`
- Instala extensões PHP `sqlsrv` e `pdo_sqlsrv`
- Instala Composer
- Define `/var/www/html` como diretório de trabalho

## 2. docker-compose.yml

- Serviços:
  - **app**:
    - Build via Dockerfile local
    - Monta volume do Laravel e script `entrypoint.sh`
    - Depende do serviço `sqlserver`
    - Usa `entrypoint.sh` como entrypoint para executar scripts na inicialização
  - **sqlserver**:
    - Imagem oficial Microsoft SQL Server 2019
    - Variáveis de ambiente para senha, aceitar EULA e tipo de licença
    - Mapeia porta 1433
    - Volume persistente para dados

- Rede personalizada `laravelnet`
- Volume para persistência de dados SQL Server

## 3. entrypoint.sh

- Espera o SQL Server estar disponível (loop com `sqlcmd`)
- Cria o banco `teste_docker_laravel` caso não exista
- Aguarda o banco ficar pronto
- Executa as migrations Laravel com `php artisan migrate --force`
- Finalmente inicia o PHP-FPM para o container Laravel

**Importante:** está montado e chamado como entrypoint no serviço app

## 4. Variáveis de ambiente do Laravel (.env)

```env
DB_CONNECTION=sqlsrv
DB_HOST=laravel-sqlserver
DB_PORT=1433
DB_DATABASE=teste_docker_laravel
DB_USERNAME=sa
DB_PASSWORD=ABj!010359
DB_OPTIONS='TrustServerCertificate=true'