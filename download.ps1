$ErrorActionPreference = 'Stop'
$raw = Join-Path $PSScriptRoot 'data/raw'
New-Item -ItemType Directory -Force -Path $raw | Out-Null
$sources = @{
  'spending.csv' = 'https://ourworldindata.org/grapher/historical-gov-spending-gdp.csv'
  'spending.metadata.json' = 'https://ourworldindata.org/grapher/historical-gov-spending-gdp.metadata.json'
  'income.csv' = 'https://ourworldindata.org/grapher/gdp-per-capita-worldbank.csv'
  'income.metadata.json' = 'https://ourworldindata.org/grapher/gdp-per-capita-worldbank.metadata.json'
  'continents.csv' = 'https://ourworldindata.org/grapher/continents-according-to-our-world-in-data.csv'
}
foreach ($entry in $sources.GetEnumerator()) {
  Invoke-WebRequest -Uri $entry.Value -OutFile (Join-Path $raw $entry.Key)
}
Write-Output 'Downloads complete. Retain the metadata download dates when refreshing the build.'
