# 🚀 Laravel + SQL Server + Docker

Ambiente completo e automatizado para desenvolvimento Laravel com SQL Server via Docker. Ideal para quem precisa integrar Laravel com bancos Microsoft de forma simples, rápida e robusta.

---

## ✅ O que este projeto oferece

- Laravel 10 configurado com Docker
- SQL Server 2019 em contêiner
- PHP 8.2 com extensões `sqlsrv` e `pdo_sqlsrv` habilitadas
- Docker Compose com serviços orquestrados (app + banco)
- Migrations automáticas na inicialização do container
- Documentação clara, com exemplos práticos e resolução de erros comuns

---

## 🛠️ Pré-requisitos

- Docker
- Docker Compose
- Git

---

## ⚙️ Como usar

```bash
git clone https://github.com/LuizGustavoVJ/laravel-docker-sqlserver-guide.git
cd laravel-docker-sqlserver-guide
docker-compose up -d

---

## 📄 Documentação técnica

Para detalhes sobre o `Dockerfile`, `docker-compose.yml`, script de entrada e variáveis de ambiente, acesse:  
👉 [`docs/setup.md`](docs/setup.md)

---

## 👨‍💻 Autor

**Luiz Gustavo Finotello**  
Especialista em infraestrutura, desenvolvimento web e integração de sistemas.  
Transformando complexidade técnica em soluções reutilizáveis e bem documentadas.
🔗 [linkedin.com/in/lgfinotello](https://www.linkedin.com/in/lgfinotello/)