# Download latest version and update widget
curl -s https://raw.githubusercontent.com/aCluelessDanny/UeberPlayer/master/UeberPlayer.widget.zip > ../ueberplayer_update.zip &&
unzip -o ../ueberplayer_update.zip -d ../ueberplayer_update &&

# Prepare settings for migration
if [[ -f ../configTemp.txt ]]; then
      while read line; do
            pair=($(echo "$line" | tr " " "\n"))
            sed -i '' -r "1,/(${pair[0]}: )(\"?[A-Za-z0-9.]+\"?)/{s/(${pair[0]}: )(\"?[A-Za-z0-9.]+\"?)/\1${pair[1]}/;}" ../ueberplayer_update/index.jsx
      done < ../configTemp.txt
else
      echo "Configuration not found??"
fi &&

# Update widget
mv -f UeberPlayer.widget/cache ../cache &&
rsync -a --delete ../ueberplayer_update/ UeberPlayer.widget/ &&
mv -f ../cache UeberPlayer.widget/cache &&

# Open changelog
open https://github.com/aCluelessDanny/UeberPlayer/releases/latest

# Remove temporary files
rm -rf ../configTemp.txt &&
rm -rf ../ueberplayer_update/ &&
rm -rf ../ueberplayer_update.zip &&

# Touch the main file to refresh widget
sleep 1
touch UeberPlayer.widget/index.jsx
