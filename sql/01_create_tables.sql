-- ============================================================================
-- 01_create_tables.sql
-- Amazon Carbon Flux — 2005 Drought Analysis
--
-- Purpose: create the empty database schema — three RELATED tables that will
--          hold the cleaned K34 flux-tower data.
--
-- Run with:   sqlite3 data/flux.db < sql/01_create_tables.sql
--
-- Note: anything after a double dash (--) on a line is a COMMENT. SQLite ignores
--       it. Every SQL statement ends with a semicolon (;).
-- ============================================================================


-- Make this script safe to RE-RUN. If the tables already exist, drop (delete)
-- them first, so running this file again rebuilds a clean, empty schema instead
-- of erroring with "table already exists".
-- Order matters: drop the tables that POINT AT sites (flux, weather) BEFORE we
-- drop sites itself.
DROP TABLE IF EXISTS flux;
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS sites;


-- ----------------------------------------------------------------------------
-- TABLE 1: sites  — one row per measurement location.
-- For this project we will have exactly ONE row: the K34 Manaus tower.
-- This is the "parent" table; flux and weather both refer back to it.
-- ----------------------------------------------------------------------------
CREATE TABLE sites (
    site_id          TEXT PRIMARY KEY,   -- short unique code, e.g. 'K34'
    name             TEXT NOT NULL,      -- readable name, e.g. 'Manaus ZF2 K34'
    latitude         REAL,               -- decimal degrees (negative = south)
    longitude        REAL,               -- decimal degrees (negative = west)
    vegetation_type  TEXT,               -- e.g. 'tropical evergreen broadleaf forest'
    country          TEXT
);


-- ----------------------------------------------------------------------------
-- TABLE 2: flux  — the carbon measurement.
-- One net-ecosystem-exchange (NEE) value per site per day.
-- ----------------------------------------------------------------------------
CREATE TABLE flux (
    site_id  TEXT NOT NULL,              -- which site this reading belongs to
    date     TEXT NOT NULL,              -- calendar day as 'YYYY-MM-DD' (SQLite has no date type)
    nee      REAL,                       -- net ecosystem exchange (umol CO2 m-2 s-1); NULL if missing

    PRIMARY KEY (site_id, date),                     -- one row per site per day
    FOREIGN KEY (site_id) REFERENCES sites(site_id)  -- site_id must exist in sites
);


-- ----------------------------------------------------------------------------
-- TABLE 3: weather  — the environmental conditions.
-- One row per site per day. Kept SEPARATE from flux so each table has one clear
-- job: flux = carbon, weather = the conditions that might explain the carbon.
-- ----------------------------------------------------------------------------
CREATE TABLE weather (
    site_id        TEXT NOT NULL,
    date           TEXT NOT NULL,
    air_temp       REAL,                 -- ta        — air temperature (deg C)
    soil_moisture  REAL,                 -- totalteta — total soil moisture (m3/m3)
    vpd            REAL,                 -- VPD       — vapour pressure deficit (kPa)
    radiation      REAL,                 -- rg        — incoming solar radiation (W/m2)
    precip         REAL,                 -- prec      — precipitation (mm)

    PRIMARY KEY (site_id, date),
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);
