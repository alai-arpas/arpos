# Questi sono i comandi utilizzati in
# make pub

mix hex.build
# git tag -a $(versione) -m $(versione)
git tag -a "v0.1.0" -m "v0.1.0"

# git push origin "v0.1.1"
git push origin $(versione)

mix hex.publish
