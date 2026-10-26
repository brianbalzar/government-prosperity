# Government spending & economic prosperity

Open `index.html` in a modern browser. It is a self-contained, offline visualization: no server, installation or live data requests are needed. The updated design follows the supplied `government-prosperity.html` reference, with its fonts embedded for offline use. The original version and supplied design reference are preserved locally in `previous/` and `reference/`; these backup folders, ZIP packages and QA screenshots are excluded from Git.

## GitHub Pages

The published site is [brianbalzar.github.io/government-prosperity](https://brianbalzar.github.io/government-prosperity/). GitHub Pages serves the repository's `main` branch at its root. `.nojekyll` lets GitHub serve the generated static HTML directly. No runtime services or API keys are needed. To publish updates, run `node build.cjs`, verify the changes, commit the generated `index.html` together with its source changes, and push to `main`.

The existing workspace was inspected first. Its related healthcare work uses health expenditure and current-dollar GDP, which do not answer this question. Existing projects were preserved; this project has its own source snapshots and build.

## Included views

- A 2024 scatterplot of 149 countries, with total expenditure (% GDP) against GDP per capita (PPP, constant 2021 international dollars). The income axis is explicitly logarithmic. Country colors and continent controls are consistent across both views.
- An unweighted descriptive OLS fit: spending = a + b × ln(income). The full sample has R² = 0.141741 and approximately +3.19708 percentage points of spending share per doubling of income. This is an association, not a causal estimate.
- A sortable country-by-year heatmap, with 3,725 annual cells and changes from 2000 to 2024. **Spending level / Annual change** switches between levels and consecutive-year differences in percentage points, with level as the default. The annual-change scale is fixed and symmetric around zero: blue for decreases, neutral for zero, orange for increases; colors saturate at ±10 pp to make typical movements visible. Exact values remain in tooltips. 2000 has no annual change because the retained series starts in 2000; differences across missing years are never calculated. Tooltips in either mode show both level and annual change. The right column always reports the total 2000–2024 change; sorting by Change uses that total in either mode.
- Sort heatmap rows by total change, 2024 spending share, income or country name. **Highlight 2020** emphasizes the COVID-year column across all rows and mutes other years in either measure; both settings persist across sorting, filtering and switching views. Toggle it off to restore normal emphasis. The spending-level color scale saturates at 60% and floors at 10%; exact values are retained in tooltips and downloads. CSVs retain the original spending levels from which annual changes are calculated.
- All 149 country line facets remain available through the alternate **Line facets** view. Each has 25 annual observations, a 2020 reference guide and a labeled 2024 endpoint. The shared 0–110% range covers the full historical range (2.489422–108.830505%). No smoothing, clipping or per-country rescaling is applied to line charts, including the inspector mini-chart.
- Continent, OECD, EU, G20 and sample-income-quartile grouping controls. Switching groups resets the included categories; category toggles filter the fit and both trend views. Excluded countries remain grey context dots and are omitted from the regression and trends.
- Exact-name country search, a pinned country inspector with annual line chart and residual/change summaries, mouse/touch tooltips, a native country selector, an accessible 2024 table and embedded CSV downloads. Search selects a country and enables its category if needed; partial search text does not filter countries.
- Fixed headline figures describe the complete sample; the regression statistics below the scatterplot update with filters. A country pinned before filtering remains in the inspector, labeled as outside the active filters when applicable.

## Sources and matching

Downloaded **October 26, 2026**. Every plotted comparison is exactly **2024**; 2025 values are excluded. Join is by ISO3 code. No closest-year substitution, population weighting or imputation. Countries without both 2024 indicators are excluded. In the spending dataset, Venezuela and Yemen lack matched 2024 GDP per capita; other economies without a spending observation are also outside the sample. Included country/economy membership follows the source series.

1. **IMF Public Finances in Modern History (2025), via Our World in Data**. Total government expenditure as a share of GDP, including more than government final consumption and including interest. General government is used where available; central government otherwise. Coverage differs across countries and years. The OWID export does not provide individual observation coverage flags, so those are not inferred. OWID update: June 12, 2026.
   - [Indicator page](https://ourworldindata.org/grapher/historical-gov-spending-gdp)
   - [CSV](https://ourworldindata.org/grapher/historical-gov-spending-gdp.csv)
   - [Metadata JSON](https://ourworldindata.org/grapher/historical-gov-spending-gdp.metadata.json)
   - [IMF source](https://www.imf.org/external/datamapper/datasets/FPP)
2. **World Bank WDI, via OWID**, GDP per capita, PPP, constant 2021 international dollars. WDI indicator `NY.GDP.PCAP.PP.KD`. Producer attribution in OWID: Eurostat, OECD, IMF and World Bank (2026). OWID update: July 27, 2026.
   - [Indicator page](https://ourworldindata.org/grapher/gdp-per-capita-worldbank)
   - [CSV](https://ourworldindata.org/grapher/gdp-per-capita-worldbank.csv)
   - [Metadata JSON](https://ourworldindata.org/grapher/gdp-per-capita-worldbank.metadata.json)
   - [World Bank indicator](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.KD)
3. **OWID continent classification**: [CSV](https://ourworldindata.org/grapher/continents-according-to-our-world-in-data.csv). Country membership and continent assignments are taken from the sources.

The 2024 comparison uses historical source observations, not 2025 forecasts. Historical figures may still be estimates or subsequently revised; “actual year” does not imply final audited figures. Per-country fiscal coverage and reporting conventions limit direct comparability. Spending shares are not taxes, deficits, debt, regulation, effectiveness or quality of life. Changes in spending shares reflect both spending and the GDP denominator. The visualization retains outliers rather than judging them as good or bad.

OWID processing is CC BY. Original provider terms apply to underlying data. See cached metadata for attribution. France has a source annotation about a 1978 definition break, outside the displayed trend window.

## Files and reproducibility

- `index.html`: finished standalone visualization, with embedded data and styles.
- `template.html`: editable page markup.
- `styles.css`, `fonts.css`: responsive presentation styles and embedded font assets from the supplied reference.
- `app.js`, `controls.js`: chart rendering and grouping/heatmap/inspector interactions.
- `method-fragment.html`: source attribution and methodology.
- `data/raw/`: untouched downloaded source CSV and metadata snapshots.
- `data/processed/matched.json`: matched dataset, annual histories and membership.
- `data/processed/matched-2024.csv`: full-precision matched 2024 observations.
- `data/processed/trends-2000-2024.csv`: full-precision annual spending observations.
- `data/audit.json`: source SHA-256 hashes, exclusions, bounds, OLS coefficients and all 18 requested QA countries.
- `build.cjs`: dependency-free Node build; validates required country coverage, finite measures, unique country-year observations and agreement between 2024 endpoints and scatter values.
- `inspect.cjs`: CSV parser and optional data inspection.
- `download.ps1`: explicit source-download recipe.
- `verify-redesign.cjs` and `qa/redesign-report.json`: current browser interaction and responsive-layout validation; screenshots are in `qa/`. Earlier QA files refer to the preserved first version.

Rebuild from the supplied raw snapshots with `node build.cjs`. This does not require network access or change source data. The snapshot download date and 2024 comparison are intentionally fixed in the build. To refresh sources, run `download.ps1`, then update the download date and source-update descriptions in the build/template/README to match the new metadata before rebuilding. Recheck availability, membership and statistics after any refresh.

Browser QA uses Playwright and an installed Chrome browser. Run `node verify-redesign.cjs` after making Playwright available to Node (or set `PLAYWRIGHT_MODULE` to its package path). The regression is recalculated when category filters change, while chart domains remain fixed. Downloads contain the entire matched sample.

Group membership was checked October 26, 2026 against the [OECD](https://www.oecd.org/en/about/members-partners.html), [European Union](https://european-union.europa.eu/principles-countries-history/eu-countries_en) and [G20](https://www.g20.org.za/about-g20/g20-members/) lists. The 38 OECD members contribute 37 matched countries (Lithuania is missing); the 27 EU members contribute 25 (Lithuania and Malta are missing). All 19 G20 member countries are matched; the EU and African Union are excluded as blocs. The membership lists are fixed in `controls.js`. Sample income quartiles are formed by ranking 2024 PPP income and splitting into four approximately equal groups (38/37/37/37), not by World Bank income classifications.

## Validation performed

The requested 18-country set is present: Argentina, Australia, Brazil, Canada, China, Denmark, Finland, France, Germany, India, Italy, Japan, Mexico, South Africa, South Korea, Sweden, United Kingdom and United States. Current browser checks cover 149 dots, 3,725 heatmap cells and alternate line facets; 320, 390, 768, 1280 and 1440px widths; label collisions and page overflow; all grouping modes; exact values; country search and pinning; context dots and regression refits; heatmap sorts; 2020 cell inspection; empty state and reset; and mouse/mobile tap tooltips. This is a browser-emulated mobile layout check, not a test on physical mobile devices.
