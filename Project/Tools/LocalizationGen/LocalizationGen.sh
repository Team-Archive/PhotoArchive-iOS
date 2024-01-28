cd ${PROJECT_DIR}/../../Tools/LocalizationGen
curl -L "https://docs.google.com/feeds/download/spreadsheets/Export?key=17oAbgIhn6K4IGjjxEUgtpKJX9vf2YTMbzuRN5-QY56E&exportFormat=csv&gid=0" -o "localization.csv"
./LocalizationGen outputPath="../../Projects/App/Resources/Localization" keyColumnKey="key" platform="Apple" fileName="Localizable.strings" localColumnKeys="ko&en" inputPath="./localization.csv"
rm ./localization.csv
curl -L "https://docs.google.com/feeds/download/spreadsheets/Export?key=17oAbgIhn6K4IGjjxEUgtpKJX9vf2YTMbzuRN5-QY56E&exportFormat=csv&gid=2066908154" -o "localization.csv"
./LocalizationGen outputPath="../../Projects/App/Resources/Localization" keyColumnKey="key" platform="Apple" fileName="InfoPlist.strings" localColumnKeys="ko&en" inputPath="./localization.csv"
rm ./localization.csv