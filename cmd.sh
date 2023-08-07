git tag -a "v0.1.1" -m "v0.1.1"

git push origin "v0.1.1"

mix hex.build
mix hex.publish