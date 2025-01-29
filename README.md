# 📌 Financial  

![Financial App](https://via.placeholder.com/800x400.png?text=Financial+App)  

## 💰 Sobre o Projeto  
O **Financial** é um aplicativo para registrar e gerenciar **dívidas, compras parceladas e gastos no cartão de crédito**. Ele permite que o usuário acompanhe seus pagamentos, receba notificações e tenha um melhor controle financeiro.  

---

## 📖 Índice  

- [📌 Financial](#-financial)  
- [💰 Sobre o Projeto](#-sobre-o-projeto)  
- [🛠️ Tecnologias](#️-tecnologias)  
- [⚙️ Configuração do Ambiente](#️-configuração-do-ambiente)  
- [🚀 Instalação](#-instalação)  
- [📂 Estrutura do Projeto](#-estrutura-do-projeto)  
- [✨ Funcionalidades](#-funcionalidades)  
- [📏 Padrões de Código](#-padrões-de-código)  
- [📦 Dependências](#-dependências)  
- [🚀 Deployment](#-deployment)   
- [🤝 Contribuição](#-contribuição)  
- [📜 Licença](#-licença)  

---

## 🛠️ Tecnologias  

O projeto foi desenvolvido com as seguintes tecnologias:  

- [Flutter](https://flutter.dev/) (versão 3.12.0 ou superior)  
- [Dart](https://dart.dev/) (versão 2.18 ou superior)  
- Firebase (Autenticação, Firestore, Notificações)  
- [Provider](https://pub.dev/packages/provider)  
- [fl_chart](https://pub.dev/packages/fl_chart) para gráficos  

---

## ⚙️ Configuração do Ambiente  

### ✅ Pré-requisitos  
Antes de começar, você precisa ter:  

- **Flutter SDK** instalado  
- **Dart** instalado  
- **Android Studio** ou **Xcode** para testes  
- Um **emulador** ou **dispositivo físico** configurado  

---

## 🚀 Instalação  

### 1️⃣ Clone o repositório  

```bash
git clone https://github.com/SavioVitorAlves/Financial.git  
cd financial  
```
### 2️⃣ Instale as dependências
```bash
flutter pub get
```
### 3️⃣ Execute o projeto
```bash
flutter run
```
## 📂 Estrutura do Projeto
```plaintext
financial/  
├── lib/  
│   ├── main.dart                 # Arquivo principal do aplicativo  
│   ├── screens/                  # Contém todas as telas do app  
│   ├── models/                   # Modelos de dados  
│   ├── services/                 # Serviços como notificações e cálculos  
│   ├── utils/                    # Helpers e funções auxiliares  
│   ├── widgets /                 # Widgets reutilizáveis
|   ├── assets/imgs               # Imagens 
├── pubspec.yaml                  # Dependências do Flutter  
└── README.md                     # Documentação do projeto
```

## ✨ Funcionalidades
### ✔ Tela Principal
Saldo em conta;
Extrado das Transasões pagas;
Botões de Operações.
### ✔ Tela Emprestado, Compras Parceladas e Cartões de Credito
Valor de todo o dinheiro emprestado para pessoas;
Lista de Pessoas e valor que esta devendo para cada uma.
### ✔ Tela de Pessoas, Loja e Cartão
Valor que esta devendo para essa pessoa;
Lista de Valores que foram adicionados.
### ✔ Tela Pagamento Concluído
Exibição de confimação de Pagamento;
Botão para voltar para tela inicial.

## 📏 Padrões de Código
O projeto segue a Guia de Estilo do Flutter e as seguintes boas práticas:

CamelCase para variáveis
PascalCase para classes
Arquitetura MVVM (Model-View-ViewModel)
Widgets reutilizáveis armazenados em components/

## 📦 Dependências
```bash
dependencies:
  flutter:
    sdk: flutter
  path: ^1.9.0
  cupertino_icons: ^1.0.8
  sqflite: ^2.4.1
  provider: ^6.1.2
  intl: ^0.20.1
  flutter_colorpicker: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: ^0.14.2
```

## 🚀 Deployment
### 📱 Android
```bash
flutter build apk --release
``` 
O APK gerado pode ser enviado para a Google Play Store
### 🍏 iOS
```bash
flutter build ios
```  
Arquivar e publicar pelo Xcode na App Store

## 🤝 Contribuição
Se deseja contribuir com o projeto, siga os passos abaixo:

1️⃣ Faça um fork do repositório
2️⃣ Crie uma branch para sua feature
3️⃣ Faça suas alterações e teste
4️⃣ Abra um Pull Request explicando as mudanças

## 📜 Licença
📄 Este projeto está sob a Licença MIT. Para mais detalhes, consulte o arquivo LICENSE.
