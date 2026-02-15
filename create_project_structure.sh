#!/usr/bin/env bash

# ================================================================
# Script de création d'arborescence – Projet "Postule pour moi"
# Version adaptée 2025–2026 – Jeunes Ambitieux
# ================================================================

set -euo pipefail

PROJECT_ROOT="postule-pour-moi"

echo "Création de la structure du projet dans : ./${PROJECT_ROOT}"
mkdir -p "${PROJECT_ROOT}"

cd "${PROJECT_ROOT}" || { echo "Impossible d'entrer dans ${PROJECT_ROOT}"; exit 1; }

# ─────────────────────────────────────────────────────────────
# Dossiers principaux
# ─────────────────────────────────────────────────────────────
mkdir -p \
  admin \
  assets/{css,js,images/icons} \
  config \
  docs \
  includes/{classes,functions,templates} \
  logs \
  process \
  scraper/{sources,parsers,database,utils,logs} \
  uploads/{cvs,photos,company-logos,exports} \
  public  # optionnel selon version – on le met pour compatibilité

# ─────────────────────────────────────────────────────────────
# Fichiers de configuration racine
# ─────────────────────────────────────────────────────────────
touch .htaccess
touch .env
touch .gitignore
touch README.md
touch installation.md

cat > .gitignore << 'EOF'
# Environnement
.env
vendor/
node_modules/

# Logs & temporaires
*.log
*.tmp
.DS_Store
Thumbs.db

# Uploads sensibles
uploads/*
!uploads/.gitkeep

# Bases de données locales
*.sql.bak
EOF

cat > .env << 'EOF'
# .env – Ne pas commiter !
DB_HOST=localhost
DB_NAME=postule_pour_moi
DB_USER=root
DB_PASS=

APP_URL=http://localhost/postule-pour-moi
APP_ENV=development
APP_DEBUG=true

# Pour le scraping (exemple pédagogique)
SCRAPER_USER_AGENT="PostulePourMoi-Educatif/1.0 (+contact@exemple.bj)"
EOF

# ─────────────────────────────────────────────────────────────
# Fichiers pages publiques / utilisateur
# ─────────────────────────────────────────────────────────────
touch \
  index.php \
  login.php \
  register.php \
  profile.php \
  dashboard.php \
  jobs.php \
  job-details.php \
  apply.php \
  applications.php \
  messages.php \
  contact.php

# ─────────────────────────────────────────────────────────────
# Admin
# ─────────────────────────────────────────────────────────────
touch admin/{index.php,login.php,users.php,companies.php,jobs.php,applications.php,scraping.php,analytics.php,reports.php,settings.php}

# ─────────────────────────────────────────────────────────────
# Process (traitements POST)
# ─────────────────────────────────────────────────────────────
touch process/{login.php,register.php,apply.php,message.php,logout.php}

# ─────────────────────────────────────────────────────────────
# Includes – classes & fonctions
# ─────────────────────────────────────────────────────────────
touch includes/classes/{Database.php,User.php,Profile.php,Company.php,Job.php,Application.php,Skill.php,Message.php,Notification.php,Recommendation.php,ScrapingSource.php,ScrapingLog.php,Email.php,PDF.php,Report.php}

touch includes/functions/{auth.php,helpers.php,validation.php,upload.php}

touch includes/templates/{header.php,footer.php,dashboard-layout.php,admin-layout.php,messages.php}

# ─────────────────────────────────────────────────────────────
# Assets
# ─────────────────────────────────────────────────────────────
touch assets/css/{public.css,dashboard.css,admin.css,print.css}
touch assets/js/{public.js,dashboard.js,admin.js}
# Un petit fichier vide pour éviter suppression dossier
touch assets/images/icons/.gitkeep

# ─────────────────────────────────────────────────────────────
# Uploads – protection
# ─────────────────────────────────────────────────────────────
touch uploads/.htaccess
cat > uploads/.htaccess << 'EOF'
Deny from all
<FilesMatch "\.(pdf|jpg|jpeg|png|gif)$">
    Order Allow,Deny
    Allow from all
</FilesMatch>
EOF
touch uploads/{cvs,photos,company-logos,exports}/.gitkeep

# ─────────────────────────────────────────────────────────────
# Scraper Python
# ─────────────────────────────────────────────────────────────
touch scraper/{main.py,requirements.txt}
touch scraper/sources/{indeed.py,linkedin.py,emploi_bj.py,local_test.py}
touch scraper/parsers/job_parser.py
touch scraper/database/mysql_connector.py
touch scraper/utils/{deduplication.py,logger.py,config.py}
touch scraper/logs/.gitkeep
touch scraper/logs/scraper.log    # fichier vide

# ─────────────────────────────────────────────────────────────
# Docs & base de données
# ─────────────────────────────────────────────────────────────
touch docs/{database.sql,seed.sql,scraping.sql,installation.md}

# ─────────────────────────────────────────────────────────────
# Logs serveur
# ─────────────────────────────────────────────────────────────
touch logs/.htaccess
cat > logs/.htaccess << 'EOF'
Deny from all
EOF
touch logs/{access.log,error.log,admin.log}

echo ""
echo "Structure créée avec succès !"
echo ""
echo "Prochaines étapes suggérées :"
echo " 1. cd ${PROJECT_ROOT}"
echo " 2. Créer la base de données MySQL et importer docs/database.sql"
echo " 3. Configurer .env avec tes identifiants MySQL"
echo " 4. Commencer par config/database.php ou includes/classes/Database.php"
echo ""
tree -L 3   # si tree est installé, sinon commente cette ligne