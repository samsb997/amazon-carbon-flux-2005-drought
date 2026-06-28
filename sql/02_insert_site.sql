-- ============================================================================
-- 02_insert_site.sql
-- Amazon Carbon Flux — 2005 Drought Analysis
--
-- Purpose: put the FIRST record into the database — the single row that
--          describes the K34 Manaus tower — into the `sites` table.
--
-- Run with:   sqlite3 data/flux.db < sql/02_insert_site.sql
-- ============================================================================

-- Make this script safe to RE-RUN: remove any existing K34 row first, so we
-- don't hit a "duplicate primary key" error if the script runs a second time.
-- (Same idea as the DROP IF EXISTS in 01 — just at the row level.)
DELETE FROM sites WHERE site_id = 'K34';

-- INSERT adds ONE new row.
--   * First the list of COLUMNS we are filling, in brackets.
--   * Then VALUES, in the SAME ORDER as those columns.
-- Text goes in 'single quotes'; numbers do not. Negative numbers mean
-- south (latitude) and west (longitude).
INSERT INTO sites (site_id, name, latitude, longitude, vegetation_type, country)
VALUES ('K34', 'Manaus ZF2 K34', -2.609, -60.209, 'tropical evergreen broadleaf forest', 'Brazil');
