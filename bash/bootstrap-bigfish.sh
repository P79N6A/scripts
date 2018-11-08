
git fetch && git rebase -i
rm -rf node_modules yarn.lock
ayarn
npx lerna clean --yes
find ./packages -type f -name "yarn.lock" -exec rm -rf {} \;
npx lerna bootstrap --npm-client=ayarn
cd packages/bigfish
yarn link umi
cd -
cd packages/umi-plugin-bigfish
yarn link umi-pugin-react
cd -
npm run build
npm run e2etest
