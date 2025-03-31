cd /data

if [ -f mvs-tk5.zip ]; then
  rm -f mvs-tk5.zip*
fi

wget https://www.prince-webdesign.nl/images/downloads/mvs-tk5.zip
if [ $? -ne 0 ]; then
  echo "Error downloading mvs-tk5.zip"
  exit 1
fi

unzip mvs-tk5.zip
if [ $? -ne 0 ]; then
  echo "Error unzipping mvs-tk5.zip"
  exit 1
fi

ls -al /data

mv mvs-tk5/* /data
if [ $? -ne 0 ]; then
  echo "Error moving files"
  exit 1
fi
rm -rf mvs-tk5 mvs-tk5.zip

apk del wget zip
