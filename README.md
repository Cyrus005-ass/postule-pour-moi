# Postule pour Moi 🚀

Application web éducative d’aide à l’emploi (inspirée LinkedIn mais simplifiée)  
Projet pédagogique réalisé par **Jeunes Ambitieux** – Étudiants en informatique au Bénin.

## Objectif
- Créer un profil pro  
- Consulter / centraliser des offres d’emploi  
- Postuler facilement  
- **Bonus éducatif** : scraping pédagogique d’offres (Python + BeautifulSoup)

## Technologies utilisées
- **Frontend** : HTML, CSS, JavaScript (bientôt Bootstrap)  
- **Backend** : PHP 8 (POO + MVC simplifié)  
- **Base de données** : MySQL (PDO)  
- **Scraping** : Python (requests, BeautifulSoup)  
- Serveur : Apache (WAMP/XAMPP)

## Structure du projetpostule-pour-moi/
├── admin/              # Interface admin
├── assets/             # CSS, JS, images
├── config/             # Connexion DB, constantes
├── docs/               # Schéma SQL, seed
├── includes/           # Classes PHP & fonctions
├── process/            # Traitements POST
├── scraper/            # Module Python
├── uploads/            # CV, photos
└── ... (pages publiques)text## Installation (local)
1. Clone le repo :  
   `git clone https://github.com/Cyrus005-ass/postule-pour-moi.git`
2. Démarre WAMP/XAMPP (Apache + MySQL)
3. Crée la base `postule_pour_moi` et importe `docs/database.sql` + `docs/seed.sql`
4. Configure `.env` avec tes identifiants MySQL
5. Accède à : http://localhost/postule-pour-moi

## Prochaines étapes
- Finaliser connexion / inscription  
- Implémenter liste des offres (jobs.php)  
- Tester le scraper pédagogique sur page HTML locale

## Contributeurs
- Cyrus-youp (lead dev & architecture)
- (à compléter avec l’équipe !)

Projet 100 % éducatif – Scraping uniquement sur données publiques / locales.
Ajoute une licence (recommandé pour les projets open)
Crée un fichier LICENSE (MIT est simple et courant) :Bashtouch LICENSEColle dedans (exemple MIT) :textMIT License

Copyright (c) 2026 Jeunes Ambitieux

Permission is hereby granted, free of charge, to any person obtaining a copy...
(tu peux copier le texte complet depuis https://choosealicense.com/licenses/mit/)
Commit les fichiers .env.example (pas le vrai .env !)Crée .env.example avec les variables vides :textDB_HOST=localhost
DB_NAME=
DB_USER=
DB_PASS=

APP_URL=http://localhost/postule-pour-moi
APP_ENV=development→ Commit ça, jamais le vrai .env
Premier vrai commit utile
Une fois que tu auras config/database.php qui marche + peut-être login.php, fais :Bashgit add .
git commit -m "feat: connexion PDO + test database + README amélioré"
git push origin main

Question pour avancer ensemble
