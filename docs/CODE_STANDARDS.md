# Normes de codage – Équipe Jeunes Ambitieux  
**Projet « Postule pour moi » – Février 2026**  

**Version** : 1.0  
**Dernière mise à jour** : 15 février 2026 par Cyrus-youp  

**Règle importante**  
Ces normes sont **obligatoires** pour tous les commits à partir du **16/02/2026**.  
Si quelqu’un veut une exception ou un assouplissement, ouvre une discussion dans le groupe avant de merger quoi que ce soit.

## Rôles & Responsabilités (contrôle qualité)

- **Cyrus-youp** (Lead dev)  
  - Revue finale des pull requests  
  - Résolution des conflits de normes  
  - Mise à jour du présent document  

- **Eliel** & **Ebenezer**  
  - Relecture technique PHP / backend  
  - Sécurité, POO, architecture  

- **Sabalimath** & **Fleurick**  
  - Relecture HTML / CSS / JavaScript  
  - Cohérence visuelle, méthode BEM  

- **Tous les membres**  
  - Respect strict des normes avant chaque commit / push  

## 1. Langue

- **Anglais** : noms de variables, fonctions, méthodes, classes, fichiers, tables, colonnes  
- **Français** : commentaires, messages d’erreur (utilisateur + logs), messages de commit Git  

Exemple PHP accepté :

```php
// Récupère un utilisateur par son identifiant
public function getUserById($id)
{
    // ...
}

throw new Exception("Le mot de passe est trop court (minimum 8 caractères)");
Exemples de commits valides :
textfeat: ajout de la méthode getUserById dans UserModel
fix: correction de l'erreur SQL dans la liste des offres
docs: mise à jour du README avec les nouvelles normes
style: uniformisation de l'indentation dans login.php
2. Indentation & formatage

Indentation : tabulation uniquement (\t)
Interdiction : espaces multiples pour indenter
VS Code recommandé : editor.insertSpaces: false + editor.tabSize: 4
Longueur de ligne : viser < 100–110 caractères (souplesse autorisée)

3. Nommage – PHP (backend)

<img width="836" height="354" alt="image" src="https://github.com/user-attachments/assets/850d5ed4-2c1e-48b4-8be2-91c07ab68116" />


ÉlémentConventionExemples validesVariables$camelCase$userData, $jobList, $cvFilePathFonctions / méthodescamelCase()getAllJobs(), createApplication()ClassesPascalCaseUserModel, JobController, AuthServiceConstantesUPPER_SNAKE_CASEMAX_CV_SIZE, SESSION_TIMEOUTFichiers (classes)PascalCase.phpUserModel.php, Job.phpFichiers (pages)kebab-case.phpjob-details.php, login-process.php
4. Signature des fonctions PHP
Typage fortement recommandé quand pertinent, mais pas obligatoire si ça complexifie le code inutilement.
Préféré :
PHPpublic function getUserById($id)
public function createJob($title, $companyId, $description)
public function updateProfile($userId, array $data)
Optionnel (mais apprécié) :
PHPpublic function getUserById(int $id): ?array
5. Structure type d’un fichier PHP (copie-colle ce modèle)
PHP<?php
// Fichier : backend/models/UserModel.php
// Auteur  : Cyrus-youp
// Date    : 15/02/2026

class UserModel
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    // Récupère un utilisateur par son identifiant
    public function getUserById($id)
    {
        $stmt = $this->db->prepare("SELECT * FROM users WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch();
    }

    // Vérifie si l'email existe déjà
    public function emailExists($email)
    {
        // ...
    }
}
6. Python (dossier scraper/)

Variables et fonctions → snake_case
Classes → PascalCase
Commentaires et docstrings → français

Python# Fichier : scraper/sources/emploi_bj.py

def extraire_offres(page_html):
    """Extrait les offres d'emploi depuis la page HTML"""
    # code...
    pass
7. SQL

Tables          : pluriel, minuscules → users, jobs, applications
Colonnes        : snake_case, minuscules → user_id, created_at, cv_filename
Clé primaire    : id
Clés étrangères : xxx_id

8. JavaScript

Variables et fonctions → camelCase
Constantes → UPPER_SNAKE_CASE
Commentaires → français

JavaScript// Récupère la liste des offres depuis l'API
async function chargerOffres() {
    const response = await fetch('/api/jobs.php');
    // ...
}
9. HTML / CSS – Méthode BEM conseillée
HTML<div class="job-card job-card--urgent">
    <h3 class="job-card__title">Développeur PHP</h3>
</div>
CSS.job-card {}
.job-card__title {}
.job-card--urgent {}
10. Chemins de fichiers (dans commentaires & doc)
Toujours indiquer le chemin relatif à la racine :
PHP// Fichier  : backend/models/UserModel.php
// Inclut   : config/database.php
Python# Fichier  : scraper/main.py
# Appelle  : parsers/job_parser.py
11. Git – Messages de commit

Langue : français obligatoire
Première ligne : minuscule, pas de point final, < 72 caractères idéalement

Types principaux :

feat: nouvelle fonctionnalité
fix: correction de bug
refactor: amélioration sans changer le comportement
docs: documentation
style: formatage / normes de code

Exemples corrects :
textfeat: implémentation de la récupération des offres par compétence
fix: correction de l'upload CV qui plantait avec les accents
refactor: simplification de la classe AuthService
docs: ajout des normes de codage dans CODE_STANDARDS.md
12. Règles de sécurité minimales (obligatoires)

Jamais de mot de passe, clé API ou .env dans Git
Requêtes préparées PDO toujours (pas de concaténation SQL)
Valider / sanitizer tous les inputs ($_POST, $_GET, $_FILES)
Limiter les uploads (CV, photo) → max 2 Mo par défaut
htmlspecialchars() sur tout affichage de données utilisateur
En production : display_errors = Off

Outils recommandés

Éditeur : VS Code + extensions
PHP Intelephense
PHP CS Fixer ou PHP_CodeSniffer
EditorConfig for VS Code
Prettier (JS / CSS / HTML)

Navigateur : Chrome + extension WhatRuns
Git : terminal Git, GitHub Desktop ou GitKraken (optionnel)

Règle d’or
👉 Avant chaque commit : relire ces normes et vérifier que ton code les respecte.
