# registro_ponto

Aplicativo de Registro de Ponto — Flutter

Sistema mobile para registro de ponto eletrônico, desenvolvido em Flutter, com integração ao Firebase para autenticação e armazenamento de dados.
Inclui autenticação biométrica, registro de localização e dashboard de presença.

## 1. Aplicativo Mobile em Flutter
- Funcionalidades Implementadas
- Funcionalidade	Descrição
- Login com Firebase Auth. Autenticação com e-mail e senha via Firebase Authentication
- Autenticação biométrica.Impressão digital ou reconhecimento facial com local_auth
- Geolocalização ,Captura automática da posição GPS no momento do registro
- Registro de ponto	Entrada e saída com data, hora e coordenadas
- Dashboard	Listagem dos registros do usuário autenticado
- Logout seguro	Encerramento de sessão com Firebase Auth

## 2. Arquitetura e Estrutura do Projeto
lib/
├── main.dart                        # Inicialização do app
├── services/
│   ├── auth_service.dart            # Autenticação Firebase e Biometria
│   ├── location_service.dart        # Serviço de geolocalização
│   └── firestore_service.dart       # Interação com Cloud Firestore
├── view_models/
│   └── auth_view_model.dart         # Lógica de autenticação e estado
├── views/
│   ├── login_page.dart              # Tela de login
│   ├── register_page.dart           # Tela de cadastro
│   ├── home_page.dart               # Tela principal (Dashboard)
│   └── ponto_page.dart              # Registro de ponto
└── widgets/
    └── custom_button.dart           # Componentes reutilizáveis

## 3. Relatório de Implementação
  Descrição Técnica

O aplicativo foi desenvolvido em Flutter, utilizando arquitetura em camadas, separando:

Camada de serviço → responsável por comunicação com Firebase e recursos nativos (biometria e GPS);

Camada de view model → responsável pela lógica de autenticação e estado;

Camada de views → interface com o usuário.

## Integrações Externas
Serviço / API	Uso no Projeto
Firebase Authentication	Login e logout de usuários
Cloud Firestore	Armazenamento dos registros de ponto
Geolocator	Captura da localização GPS
Local Auth	Autenticação biométrica
Configuração Firebase:

Projeto criado no console do Firebase

google-services.json inserido em android/app

Ativada autenticação por e-mail/senha

Firestore configurado em modo de teste para desenvolvimento

Configuração Geolocator:

Permissões adicionadas no AndroidManifest.xml:

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

Configuração Local Auth:

Emulador ou dispositivo físico com impressão digital habilitada

Dependência local_auth configurada no pubspec.yaml

## Decisões de Design

Uso do Firebase Auth em vez de banco local → para garantir autenticação segura e escalável.

Armazenamento dos registros em Cloud Firestore → acesso em tempo real.

Autenticação biométrica após login → reforça segurança no acesso.

Geolocalização integrada ao registro de ponto → validação de presença física no local.

- Desafios Encontrados & Soluções
    Desafio	Solução Implementada
Erros de compatibilidade com local_auth	Atualização da dependência para versão 3.0.0 e uso de AuthenticationOptions
Crash de memória no emulador	Aumento de RAM no AVD e otimização da inicialização
    Permissões de localização não funcionando no AndroidConfiguração correta no AndroidManifest.xml e checagem dinâmica em tempo de execução
Delay no carregamento inicial	Uso de WidgetsFlutterBinding.ensureInitialized() e inicialização assíncrona

## 4. Documentação de Instalação e Uso
 Pré-requisitos

Flutter SDK instalado (>=3.0)

Android Studio ou VSCode

Conta no Firebase

Emulador Android com fingerprint ou dispositivo físico

Configurar Firebase

Criar projeto no Firebase Console

Baixar google-services.json e colocar em android/app/

Ativar Auth → Email/Senha

Ativar Firestore Database

Configurar permissões no Android
Editar AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>

## 5. Fluxos do Sistema
 Autenticação + Biometria
flowchart TD
    A[Login Page] --> B[Firebase Auth]
    B -->|Sucesso| C{Biometria habilitada?}
    C -->|Sim| D[Local Auth]
    C -->|Não| E[Home Page]
    D -->|OK| E[Home Page]
    D -->|Falha| A
