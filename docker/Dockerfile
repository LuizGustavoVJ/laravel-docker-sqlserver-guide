FROM php:8.2-fpm

ENV ACCEPT_EULA=Y \
    DEBIAN_FRONTEND=noninteractive

# 0) Remover sources list duplicados que causam warnings
RUN rm -f /etc/apt/sources.list.d/debian.sources

# 1) Criar sources.list com mirrors HTTPS para Debian bookworm
RUN echo "deb https://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list \
 && echo "deb https://deb.debian.org/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list \
 && echo "deb https://deb.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list

# 2) Ferramentas básicas e dependências
RUN apt-get update --fix-missing && apt-get install -y --fix-missing \
    curl \
    apt-transport-https \
    gnupg2 \
    ca-certificates \
    lsb-release \
    unixodbc-dev \
    build-essential

# 3) Repositório Microsoft ODBC
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg \
 && echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] \
    https://packages.microsoft.com/debian/$(lsb_release -rs)/prod \
    $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/mssql-release.list

# 4) Instalação do driver ODBC SQL Server
RUN apt-get update --fix-missing \
 && ACCEPT_EULA=Y apt-get install -y --fix-missing msodbcsql18

# 5) Extensões SQLSRV no PHP
RUN pecl install sqlsrv pdo_sqlsrv \
 && docker-php-ext-enable sqlsrv pdo_sqlsrv

# 6) Extensões comuns e otimizações
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends --fix-missing \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    gnupg \
    git \
    libssl-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libzip-dev \
 && docker-php-ext-install \
    pdo pdo_mysql mbstring exif pcntl bcmath gd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# 7) Composer CLI
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

WORKDIR /var/www/html
