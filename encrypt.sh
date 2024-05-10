# Cleanup
rm -rf ./dist /tmp/w3w;
mkdir ./dist /tmp/w3w /tmp/w3w/unzip;

# Unpack Google Doc
wget -O /tmp/w3w/google-doc.zip $GOOGLE_DOC;
unzip /tmp/w3w/google-doc.zip -d /tmp/w3w/unzip/;

# Substring Replacements
sed -i -e "s/SEED_PHRASE/$SEED_PHRASE/g" /tmp/w3w/unzip/CryptoAssets.html;
sed -i -e "s/PUBLISH_DATE/$SEED_PHRASE/g" /tmp/w3w/unzip/CryptoAssets.html;

# Encryption
./node_modules/staticrypt/cli/index.js -d ./dist/ -p "$ENCRYPTION_PASSWORD" /tmp/w3w/unzip/CryptoAssets.html;

# Package dist
rm /tmp/w3w/unzip/CryptoAssets.html;
cp -R /tmp/w3w/unzip/* ./dist/;

# Upload
git add ./dist/*;
git commit -m "Auto-Publish";
git push;