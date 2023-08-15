#!/bin/sh

echo "⚙️  Updating SourceKit LSP..."
pushd sourcekit-lsp > /dev/null

echo "⬇️  Downloading latests sources..."
git pull > /dev/null
echo "✅ Latest sources downloaded"

echo "🚧 Building sources..."
swift build -c release > /dev/null

echo "✅ SourceKit LSP updated"
popd > /dev/null


echo "⚙️  Updating Lua Language Server..."
pushd lua-language-server > /dev/null

echo "⬇️  Downloading latests sources..."
git pull > /dev/null
echo "✅ Latest sources downloaded"

echo "🚧 Building sources..."
./make.sh > /dev/null

echo "✅ Lua Language Server updated"
popd > /dev/null


echo "⚙️  Updating JS based language servers..."
pushd npm-available-servers  > /dev/null

yarn install > /dev/null

echo "✅ JS based language servers updated"
popd > /dev/null
