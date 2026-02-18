# Installation – Postule pour moi  
*(Mise à jour février 2026 – adaptée à votre schema actuel)*

## Prérequis

- PHP 8.1+ (avec pdo_mysql, mbstring, curl)
- MySQL 8.0+ ou MariaDB
- Apache/Nginx avec mod_rewrite
- Python 3.9+ (pour le scraping éducatif)

## Étapes

1. Copier le projet dans votre dossier web  
   ex: `/var/www/postule-pour-moi` ou `htdocs/postule-pour-moi`

2. Créer la base de données

   ```sql
   CREATE DATABASE postule_pour_moi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
