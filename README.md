A seguir, uma sugestão de descrição técnica para o README do projeto:

---

## Descrição Técnica

Este projeto é um **front-end de e-commerce** desenvolvido em Flutter, estruturado com uma arquitetura modular e escalável que adota as melhores práticas de desenvolvimento móvel. O sistema foi projetado para atender tanto a **usuários clientes** quanto a **administradores**, com fluxos e funcionalidades diferenciadas conforme o perfil de acesso.

### Principais Funcionalidades

- **Autenticação e Gerenciamento de Sessão**:  
  - Tela de login com validação de credenciais.
  - Armazenamento seguro do token de autenticação utilizando **GetStorage**.
  - Verificação e renovação da sessão para direcionar o fluxo do aplicativo.

- **Gestão de Produtos**:  
  - CRUD (criação, leitura, atualização e remoção) de produtos.
  - Upload de imagens para produtos via requisições multipart (HTTP).
  - Exibição de detalhes do produto, avaliações e seção de perguntas e respostas.

- **Gerenciamento de Categorias e Subcategorias**:  
  - Cadastro, edição e exclusão de categorias e subcategorias.
  - Filtragem dos produtos por categoria e/ou subcategoria.
  - Interface administrativa para manutenção da hierarquia de produtos.

- **Avaliações e Perguntas**:  
  - Sistema de avaliação de produtos com cálculo de média de notas.
  - Permite que os usuários enviem perguntas e que administradores respondam, integrando feedback direto sobre os produtos.

- **Carrinho de Compras e Finalização de Pedidos**:  
  - Adição, remoção e ajuste de quantidades dos itens do carrinho.
  - Cálculo do total do pedido e fluxo para finalização e confirmação de compra.

- **Gerenciamento de Usuários e Perfis**:  
  - Cadastro e edição de usuários com associação a perfis (roles) como *Admin* e *Client*.
  - Diferenciação de funcionalidades e acesso de acordo com o perfil do usuário.

### Arquitetura e Organização do Código

O projeto segue os princípios da separação de responsabilidades e é organizado em **múltiplas camadas**, garantindo uma alta coesão e baixo acoplamento entre os módulos:

- **Models (Modelos)**:  
  Representam as entidades do sistema (por exemplo, *Product*, *Category*, *User*, *Role*, *ProductRating*, etc.) e definem a estrutura dos dados.

- **Controllers (Controladores)**:  
  Utilizam a biblioteca **Provider** para gerenciar o estado da aplicação de forma reativa. Cada funcionalidade possui seu próprio controlador (ex.: *ProductController*, *CategoryController*, *UserController*, etc.), que orquestra a comunicação entre os serviços e a interface do usuário.

- **Services (Serviços)**:  
  Encapsulam a lógica de negócio e a comunicação com a API REST (utilizando o pacote **HTTP**). Cada serviço é responsável por operações CRUD e outras ações específicas (ex.: *AuthService*, *ProductService*, *CategoryService*, etc.).

- **Repositories (Repositórios)**:  
  Abstraem os detalhes de acesso à API, facilitando a manutenção e possíveis substituições ou testes de integração.

- **Widgets e Screens (Widgets e Telas)**:  
  Compostos reutilizáveis que formam a interface do usuário. As telas (screens) agrupam widgets para apresentar funcionalidades completas, como o painel de administração ou o fluxo de compras para clientes.

### Fluxo de Inicialização

A aplicação é iniciada em `lib/main.dart`, onde ocorre a inicialização do **GetStorage** e o registro dos diversos providers (controladores). Com base na existência de um token armazenado, o app direciona o usuário para a tela de **Login** ou para a interface principal do aplicativo (diferenciada para *Admin* e *Client*).

### Integração com o Backend

Todas as operações de CRUD e autenticação se comunicam com um backend hospedado na plataforma [Xano](https://xano.com/). A URL base para as requisições é configurada nos serviços, garantindo que todas as operações de rede sejam centralizadas e de fácil manutenção.

---

Essa estrutura modular e a clara separação de responsabilidades não só facilitam a escalabilidade e manutenção do código, mas também permitem a fácil integração de novas funcionalidades e adaptações para diferentes requisitos de negócio. Essa abordagem torna o projeto um exemplo robusto de como desenvolver aplicativos de e-commerce utilizando Flutter e padrões modernos de desenvolvimento.
