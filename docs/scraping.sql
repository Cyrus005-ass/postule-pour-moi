-- ============================================================================
-- scraping.sql
-- Tables + exemples pour la partie scraping (éducatif uniquement)
-- À exécuter après database.sql
-- ============================================================================

USE `postule_pour_moi`;

-- Si tu n'as pas encore ces tables (dans ton dump elles existent déjà, donc on complète)

-- Ajout de champs utiles si besoin (optionnel – à faire une seule fois)
ALTER TABLE offres 
    ADD COLUMN competences_texte TEXT NULL AFTER description,
    ADD COLUMN date_detection DATETIME NULL AFTER date_publication
    -- (utile pour savoir quand l’offre a été scrapée)
ON DUPLICATE KEY UPDATE date_mise_a_jour = CURRENT_TIMESTAMP;

-- -----------------------------------------------------------------------------
-- Exemples de logs scraping (pour tester l’affichage dans admin/scraping.php)
-- -----------------------------------------------------------------------------
INSERT IGNORE INTO scraping_logs (source_id, date_execution, offres_trouvees, offres_inserees, message, succes) VALUES
(1, '2026-02-15 18:30:00', 12, 8,  '8 nouvelles offres détectées – 4 doublons ignorés', 1),
(1, '2026-02-16 09:15:00', 9,  3,  '3 offres insérées – site modifié, parser à ajuster', 1),
(2, '2026-02-16 10:00:00', 0,  0,  'Page Indeed non trouvée ou structure changée (erreur 404 simulée)', 0);
