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
