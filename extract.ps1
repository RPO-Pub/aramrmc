### Ctrl + S on the page to save it as a .html file
### The page is https://leagueoflegends.fandom.com/wiki/List_of_champions
### Run this script in the same directory as the .html file
### The script will output a file called championMap.js

# Extract lines from a file that match a pattern
$rawHtml = Get-Content "list.html" | Select-String -Pattern "data-champion" | Select-String -Pattern "data-sort-value"

# Get the champion name
$championName = $rawHtml -replace ".*data-champion=""", ""
$championName = $championName -replace """(.*)", ""
# Replace HTML codes with characters for & and '
$championName = $championName -replace "&amp;", "&"
$championName = $championName -replace "&#39;", "'"


# Get the champion image url
$championImage = $rawHtml -replace ".*data-src=""", ""
# Reploace everthing after the first .png with nothing
$championImage = $championImage -replace "\.png(.*)", ".png"

# Map the champion name to the image url
echo "var championMap = {}" > championMap.js
$championMap = @{}
for ($i = 0; $i -lt $championName.Length; $i++) {
    $test = 'championMap["' + $championName[$i] + '"] = "' + $championImage[$i] + '";'
    echo $test >> championMap.js
}
