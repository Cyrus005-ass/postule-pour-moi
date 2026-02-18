# Installation – Postule pour moi  
*(Version février 2026 – adaptée au projet actuel de l'équipe Jeunes Ambitieux)*

## Prérequis

### Serveur web & PHP
- PHP ≥ 8.1 (avec les extensions suivantes activées) :
  - pdo_mysql
  - mbstring
  - curl
  - openssl
  - fileinfo (pour les uploads)
- Serveur web : Apache (avec mod_rewrite activé) ou Nginx
- .htaccess autorisé (AllowOverride All sur Apache)

### Base de données
- MySQL ≥ 8.0 ou MariaDB ≥ 10.5
- Utilisateur MySQL avec droits CREATE, ALTER, DROP, INSERT, SELECT, UPDATE, DELETE

### Python (pour le scraping éducatif)
- Python ≥ 3.9
- pip installé
- Bibliothèques Python nécessaires (installées plus bas)

### Recommandé (mais optionnel pour débuter)
- Composer (gestion des dépendances PHP futures)
- Git (pour le versionning)
- VS Code / PHPStorm / Sublime Text

## Étapes d’installation

### 1. Récupérer le projet

```bash
# Option 1 : via git (recommandé)
git clone <votre-url-git-du-projet> postule-pour-moi
cd postule-pour-moi

# Option 2 : ZIP téléchargé
# Décompressez dans votre dossier web (ex: htdocs/postule-pour-moi ou wamp64/www/postule-pour-moi)
2. Créer la base de données
Connectez-vous à phpMyAdmin / MySQL Workbench / ligne de commande :
SQLCREATE DATABASE postule_pour_moi 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

-- Option : créer un utilisateur dédié (plus sécurisé)
CREATE USER 'postule_user'@'localhost' IDENTIFIED BY 'votre_mot_de_passe_fort';
GRANT ALL PRIVILEGES ON postule_pour_moi.* TO 'postule_user'@'localhost';
FLUSH PRIVILEGES;
3. Importer la structure de la base
Allez dans docs/ et importez les fichiers dans cet ordre :
Bash# 1. Structure principale
mysql -u root -p postule_pour_moi < docs/database.sql

# 2. Données de test (optionnel mais très utile au début)
mysql -u root -p postule_pour_moi < docs/seed.sql

# 3. Tables liées au scraping (logs, sources, etc.)
mysql -u root -p postule_pour_moi < docs/scraping.sql
Astuce : si vous n’avez pas encore ces fichiers, commencez par créer au moins la table users (voir exemple ci-dessous).
Exemple minimal pour tester l’authentification :
SQLCREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    fullname    VARCHAR(150) NOT NULL,
    email       VARCHAR(150) UNIQUE NOT NULL,
    password    VARCHAR(255) NOT NULL,
    role        ENUM('candidat', 'recruteur', 'admin') DEFAULT 'candidat',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    active      TINYINT(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
4. Configurer la connexion à la base (PHP)
Copiez / renommez le fichier de configuration :
Bash# Si vous avez un .env.example → copiez-le
cp .env.example .env
Ou modifiez directement config/database.php :
PHP<?php
// config/database.php

define('DB_HOST', 'localhost');
define('DB_NAME', 'postule_pour_moi');
define('DB_USER', 'root');           // ou 'postule_user'
define('DB_PASS', '');               // votre mot de passe

// Pour .env (mieux) → à faire plus tard
// $dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/..');
// $dotenv->load();
// define('DB_HOST', $_ENV['DB_HOST'] ?? 'localhost');
// etc.
Test rapide : créez un fichier test-db.php à la racine :
PHP<?php
require_once 'config/database.php';
echo "Connexion OK !";
Ouvrez http://localhost/postule-pour-moi/test-db.php → si vous voyez "Connexion OK !" → c’est bon.
5. Installer les dépendances Python (scraping)
Bashcd scraper

# Créer un environnement virtuel (fortement recommandé)
python -m venv venv
# Windows : venv\Scripts\activate
# Linux/Mac : source venv/bin/activate

# Installer les packages
pip install -r requirements.txt
Contenu conseillé de scraper/requirements.txt (minimal pour commencer) :
textrequests==2.31.0
beautifulsoup4==4.12.3
lxml==5.3.0          # parseur plus rapide que html.parser
6. Tester le scraping de base
Bashcd scraper
python main_test.py
# ou
python main.py          # si vous avez déjà le script principal
Vous devez voir des offres s’afficher dans la console (si vous avez utilisé le script sur https://realpython.github.io/fake-jobs/).
7. Permissions des dossiers (très important !)
Bash# Linux / Mac
chmod -R 755 uploads/
chmod -R 755 logs/
chmod 644 .env          # si vous en avez un

# Windows : clic droit → Propriétés → Sécurité → donner "Contrôle total" à "Tout le monde" sur uploads/ et logs/ (temporaire pour tests)
8. Lancer le projet
Ouvrez votre navigateur :

http://localhost/postule-pour-moi/          → page d’accueil
http://localhost/postule-pour-moi/register.php
http://localhost/postule-pour-moi/login.php

Si vous avez déjà index.php, login.php, register.php → essayez de créer un compte.
