-- ============================================================================
-- seed.sql
-- Données de test pédagogiques – À exécuter APRÈS ton database.sql
-- ============================================================================

USE `postule_pour_moi`;

-- -----------------------------------------------------------------------------
-- Compléter les compétences (tu en avais déjà quelques-unes)
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO competences (nom) VALUES
('Git'), ('Bootstrap'), ('React'), ('Laravel'), ('MySQL'), ('Communication'),
('Travail en équipe'), ('Anglais technique');

-- -----------------------------------------------------------------------------
-- Utilisateurs de test (mots de passe en clair UNIQUEMENT pour dev local)
-- → En production : TOUJOURS utiliser password_hash()
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO users (email, password_hash, role, prenom, nom, telephone, actif) VALUES
('admin@postule.bj',        'azerty123', 'admin',     'Admin',     'Plateforme', NULL,          1),
('ebenezer@etu.bj',         'test1234',  'candidat',  'Ebenezer',  'H.',         '+229 96123456', 1),
('faustina.k@etu.bj',       'test1234',  'candidat',  'Faustina',  'K.',         '+229 97123456', 1),
('cyrus.youp@etu.bj',       'test1234',  'candidat',  'Cyrus',     'Youp',       '+229 68123456', 1),
('recruteur@techsolutions.bj', 'test1234', 'recruteur', 'Sophie',    'Zinsou',     '+229 55123456', 1);

-- -----------------------------------------------------------------------------
-- Profils candidats (un par étudiant test)
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO profils_candidats (user_id, titre, resume, localisation, pret_a_demarrer) VALUES
(2, 'Développeur PHP/Python intermédiaire', 'Passionné par le back-end et les bases de données', 'Cotonou', '2026-03-01'),
(3, 'Étudiante Front-end (HTML/CSS/JS)',     'En recherche de stage – motivée et sérieuse',        'Porto-Novo', '2026-04-01'),
(4, 'Full-stack junior – PHP & Python',      'Projets scolaires + 2 mini-projets perso',          'Cotonou', '2026-03-15');

-- -----------------------------------------------------------------------------
-- Entreprises (liées aux recruteurs)
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO entreprises (user_id, nom, description, site_web) VALUES
(5, 'Tech Solutions BJ', 'Agence digitale spécialisée web & mobile à Cotonou', 'https://techsolutions.bj');

-- -----------------------------------------------------------------------------
-- Offres internes de test
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO offres (entreprise_id, titre, description, type_contrat, salaire_min, salaire_max, localisation, source, valide, actif) VALUES
(1, 'Développeur PHP Junior – Stage', 
   'Développement d’applications web pour clients locaux. Travail en équipe avec un senior.', 
   'Stage', 80000, 150000, 'Cotonou', 'interne', 1, 1),

(1, 'Alternance Community Manager', 
   'Gestion des réseaux sociaux + création de contenu. Idéal pour étudiant en com/marketing.', 
   'Alternance', NULL, NULL, 'Cotonou ou remote', 'interne', 1, 1);

-- -----------------------------------------------------------------------------
-- Associer des compétences aux offres
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO offre_competences (offre_id, competence_id, obligatoire) VALUES
(1, (SELECT id FROM competences WHERE nom = 'HTML'),       1),
(1, (SELECT id FROM competences WHERE nom = 'CSS'),        1),
(1, (SELECT id FROM competences WHERE nom = 'PHP'),        1),
(1, (SELECT id FROM competences WHERE nom = 'SQL'),        1),

(2, (SELECT id FROM competences WHERE nom = 'Communication'), 1),
(2, (SELECT id FROM competences WHERE nom = 'Anglais technique'), 0);

-- -----------------------------------------------------------------------------
-- Quelques candidatures de test
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO candidatures (user_id, offre_id, statut, message) VALUES
(2, 1, 'en attente', 'Je suis très intéressé par ce stage. J’ai déjà fait 2 projets en PHP/MySQL pendant mes études.'),
(3, 1, 'en attente', 'Motivée pour apprendre le back-end en stage. Prête à m’investir à 100% !');

-- -----------------------------------------------------------------------------
-- Sources de scraping (éducatif)
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO scraping_sources (nom, url_base, actif) VALUES
('Emploi.bj local',   'http://localhost/tests/emploi-bj.html', 1),
('Indeed Bénin simulé', 'http://localhost/tests/indeed.html',  1);
