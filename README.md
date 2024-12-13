
# Desafio INSS

Este projeto é uma aplicação Ruby on Rails que calcula descontos de INSS para proponentes.

## Tecnologias Utilizadas

- **Ruby on Rails**: Framework web.
- **PostgreSQL**: Banco de dados.
- **Docker**: Para containerização.
- **Docker Compose**: Para orquestração dos containers.

---

## Pré-requisitos

Certifique-se de ter o Docker e o Docker Compose instalados na sua máquina.  

- [Instalar Docker](https://docs.docker.com/get-docker/)  
- [Instalar Docker Compose](https://docs.docker.com/compose/install/)  

---

## Como executar o projeto

1. **Clone o repositório:**  
   ```bash
   git clone https://github.com/josafams/inss
   cd desafio_inss
   ```

2. **Suba os containers:**  
   ```bash
   make docker-run
   ```

3. **Acesse o projeto:**  
   A aplicação estará disponível em:  
   ```
   http://localhost:8080
   
   login email: 'admin@exemplo.com', password: '123456'

   ```

4. **CI/CD:**  
  Existe um pequeno arquivo de CI no projeto
  ```  
  cat .github/workflows/test.yml 
  ```
---

## Comandos úteis

- **Criar o banco de dados:**  
  Não necessária visto que o arquivo entrypoint.sh já faz isso.

  ```bash
  docker-compose exec app rails db:create db:migrate
  ```

- **Acessar o console Rails:**  
  ```bash
  make docker-shell
  ```

- **Rodar testes:**  
  ```bash
  make docker-tests
  ```

---

## Parar os containers

Para parar e remover os containers:  
```bash
docker-compose down
```

### Arquitetura

Foi utilizada a abordagem de **Service Object**, seguindo o princípio descrito no artigo [Refactor Ruby on Rails Service Objects](https://www.honeybadger.io/blog/refactor-ruby-rails-service-object/). Essa implementação foi realizada de forma mais minimalista (*bare metal*), sem o uso de gemas ou bibliotecas externas.

Embora existam outras formas de implementar essa arquitetura, como o uso de gemas específicas, um exemplo seria o [Trailblazer](https://trailblazer.to/2.1/docs/trailblazer/).