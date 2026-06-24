# Amazon Carbon Flux — 2005 Drought Analysis

Analysing net ecosystem carbon exchange (NEE) at a central-Amazon rainforest flux
tower across the severe **2005 Amazonian drought**, using eddy-covariance data from
the NASA LBA project. Built **SQL-first** (SQLite) as a data-analysis portfolio piece.

## Question
How did the 2005 drought affect the carbon balance of central Amazon rainforest?
Did the forest stay a carbon **sink**, or flip toward a **source**, as soil moisture
fell and vapour-pressure deficit (VPD) rose?

## Data
- **Source:** NASA LBA / ORNL DAAC — *CD32 Carbon Flux from Brazilian sites*
  (dataset `CD32_Fluxes_Brazil_1842`).
- **Site:** K34 — Manaus ZF2 tower, central Amazon (−2.609°, −60.209°),
  tropical evergreen broadleaf forest.
- **File:** `K34day_CfluxBF.txt` — daily values, 1998–2006, tab-delimited, 211 columns.
- **Not included in this repo** (large, and not mine to redistribute). Download from the
  ORNL DAAC and place it in `data/`.

Key variables: `NEE_model` (net ecosystem exchange), air temperature, incoming solar
radiation, soil moisture, VPD, precipitation. Missing values are coded `-9999`.

## Approach
1. Load the raw file into a SQLite **staging** table (`.import`).
2. Clean and reshape **in SQL** — cast scientific-notation text to numbers, convert
   `-9999` → `NULL`, and build a calendar date from year + day-of-year.
3. Split into three related tables — `sites`, `flux`, `weather` — and analyse with JOINs.
4. Visualise trends in Python (matplotlib).

## Structure
```
data/      raw flux file (gitignored)
sql/       SQL scripts — schema, loading, analysis
src/       Python scripts / notebooks for figures
figures/   generated charts
```

## Status
🚧 In progress — environment and data verified; building the SQLite schema next.

> **This README is a living document.** It will be updated as the project develops —
> as the database schema, queries, analysis, and findings take shape, this file grows
> with them. Treat the latest version here as the current state of the project.

## Tech
SQLite · SQL · Python (pandas, matplotlib) · Jupyter
