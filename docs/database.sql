-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 15 fév. 2026 à 21:20
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `postule_pour_moi`
--
CREATE DATABASE IF NOT EXISTS `postule_pour_moi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `postule_pour_moi`;

-- --------------------------------------------------------

--
-- Structure de la table `candidatures`
--

DROP TABLE IF EXISTS `candidatures`;
CREATE TABLE IF NOT EXISTS `candidatures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `offre_id` int NOT NULL,
  `date_candidature` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en attente','acceptée','refusée','en cours') COLLATE utf8mb4_unicode_ci DEFAULT 'en attente',
  `message` text COLLATE utf8mb4_unicode_ci,
  `cv_version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_candidature` (`user_id`,`offre_id`),
  KEY `offre_id` (`offre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `competences`
--

DROP TABLE IF EXISTS `competences`;
CREATE TABLE IF NOT EXISTS `competences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `competences`
--

INSERT INTO `competences` (`id`, `nom`) VALUES
(7, 'C++'),
(2, 'CSS'),
(1, 'HTML'),
(3, 'JavaScript'),
(4, 'PHP'),
(5, 'Python'),
(6, 'SQL');

-- --------------------------------------------------------

--
-- Structure de la table `entreprises`
--

DROP TABLE IF EXISTS `entreprises`;
CREATE TABLE IF NOT EXISTS `entreprises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `nom` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `site_web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `entreprises`
--

INSERT INTO `entreprises` (`id`, `user_id`, `nom`, `logo_path`, `description`, `site_web`) VALUES
(1, NULL, 'Tech Solutions BJ', NULL, 'Agence digitale à Cotonou', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `experiences`
--

DROP TABLE IF EXISTS `experiences`;
CREATE TABLE IF NOT EXISTS `experiences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profil_id` int NOT NULL,
  `poste` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entreprise` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `actuel` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `profil_id` (`profil_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `offres`
--

DROP TABLE IF EXISTS `offres`;
CREATE TABLE IF NOT EXISTS `offres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entreprise_id` int NOT NULL,
  `titre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_contrat` enum('CDI','CDD','Stage','Freelance','Alternance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `salaire_min` decimal(10,0) DEFAULT NULL,
  `salaire_max` decimal(10,0) DEFAULT NULL,
  `localisation` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_publication` datetime DEFAULT CURRENT_TIMESTAMP,
  `date_cloture` date DEFAULT NULL,
  `source` enum('interne','scraped','autre') COLLATE utf8mb4_unicode_ci DEFAULT 'interne',
  `source_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valide` tinyint(1) DEFAULT '0',
  `actif` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `entreprise_id` (`entreprise_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `offres`
--

INSERT INTO `offres` (`id`, `entreprise_id`, `titre`, `description`, `type_contrat`, `salaire_min`, `salaire_max`, `localisation`, `date_publication`, `date_cloture`, `source`, `source_url`, `valide`, `actif`) VALUES
(1, 1, 'Développeur PHP Junior', 'Développement d\'applications web pour clients locaux', 'Stage', 80000, 150000, 'Cotonou', '2026-02-15 17:34:00', NULL, 'interne', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `offre_competences`
--

DROP TABLE IF EXISTS `offre_competences`;
CREATE TABLE IF NOT EXISTS `offre_competences` (
  `offre_id` int NOT NULL,
  `competence_id` int NOT NULL,
  `obligatoire` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`offre_id`,`competence_id`),
  KEY `competence_id` (`competence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `offre_competences`
--

INSERT INTO `offre_competences` (`offre_id`, `competence_id`, `obligatoire`) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 4, 1);

-- --------------------------------------------------------

--
-- Structure de la table `profils_candidats`
--

DROP TABLE IF EXISTS `profils_candidats`;
CREATE TABLE IF NOT EXISTS `profils_candidats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `titre` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resume` text COLLATE utf8mb4_unicode_ci,
  `cv_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `localisation` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pret_a_demarrer` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `profil_competences`
--

DROP TABLE IF EXISTS `profil_competences`;
CREATE TABLE IF NOT EXISTS `profil_competences` (
  `profil_id` int NOT NULL,
  `competence_id` int NOT NULL,
  `niveau` enum('débutant','intermédiaire','avancé','expert') COLLATE utf8mb4_unicode_ci DEFAULT 'intermédiaire',
  PRIMARY KEY (`profil_id`,`competence_id`),
  KEY `competence_id` (`competence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scraping_logs`
--

DROP TABLE IF EXISTS `scraping_logs`;
CREATE TABLE IF NOT EXISTS `scraping_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_id` int DEFAULT NULL,
  `date_execution` datetime DEFAULT CURRENT_TIMESTAMP,
  `offres_trouvees` int DEFAULT '0',
  `offres_inserees` int DEFAULT '0',
  `message` text COLLATE utf8mb4_unicode_ci,
  `succes` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scraping_sources`
--

DROP TABLE IF EXISTS `scraping_sources`;
CREATE TABLE IF NOT EXISTS `scraping_sources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url_base` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `dernier_scrap` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `scraping_sources`
--

INSERT INTO `scraping_sources` (`id`, `nom`, `url_base`, `actif`, `dernier_scrap`) VALUES
(1, 'Emploi.bj', 'https://exemple.emploi.bj', 1, NULL),
(2, 'Indeed Bénin', 'https://indeed.com', 0, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('candidat','recruteur','admin') COLLATE utf8mb4_unicode_ci DEFAULT 'candidat',
  `prenom` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_inscription` datetime DEFAULT CURRENT_TIMESTAMP,
  `dernier_connexion` datetime DEFAULT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `photo_profil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `role`, `prenom`, `nom`, `telephone`, `date_inscription`, `dernier_connexion`, `actif`, `photo_profil`) VALUES
(5, 'cyrus@gmail.com', 'azerty123', 'candidat', 'Cyrus', 'Youp', '+229 12345678', '2026-02-15 17:40:06', NULL, 1, NULL),
(6, 'faustina@gmail.com', 'azerty123', 'candidat', 'Faustina', 'K.', '+229 98765432', '2026-02-15 17:40:06', NULL, 1, NULL),
(7, 'admin@postule.bj', 'azerty123', 'admin', 'Admin', 'Super', NULL, '2026-02-15 17:40:06', NULL, 1, NULL),
(8, 'entreprise1@gmail.com', 'azerty123', 'recruteur', 'Sophie', 'Zinsou', '+229 55554444', '2026-02-15 17:40:06', NULL, 1, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `candidatures`
--
ALTER TABLE `candidatures`
  ADD CONSTRAINT `candidatures_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidatures_ibfk_2` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entreprises`
--
ALTER TABLE `entreprises`
  ADD CONSTRAINT `entreprises_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `experiences_ibfk_1` FOREIGN KEY (`profil_id`) REFERENCES `profils_candidats` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offres`
--
ALTER TABLE `offres`
  ADD CONSTRAINT `offres_ibfk_1` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offre_competences`
--
ALTER TABLE `offre_competences`
  ADD CONSTRAINT `offre_competences_ibfk_1` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `offre_competences_ibfk_2` FOREIGN KEY (`competence_id`) REFERENCES `competences` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `profils_candidats`
--
ALTER TABLE `profils_candidats`
  ADD CONSTRAINT `profils_candidats_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `profil_competences`
--
ALTER TABLE `profil_competences`
  ADD CONSTRAINT `profil_competences_ibfk_1` FOREIGN KEY (`profil_id`) REFERENCES `profils_candidats` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profil_competences_ibfk_2` FOREIGN KEY (`competence_id`) REFERENCES `competences` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `scraping_logs`
--
ALTER TABLE `scraping_logs`
  ADD CONSTRAINT `scraping_logs_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `scraping_sources` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
