#!/bin/bash

echo "--- react アプリケーション雛形の作成 ---"
read -p "アプリ名: " APP_NAME
npx create-react-app $APP_NAME --template typescript
cd $APP_NAME

echo "--- eslint, prettier 設定 ---"
npm i -D eslint prettier eslint-config-prettier typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin @types/react @types/react-dom eslint-plugin-react eslint-plugin-react-hooks

TS_CONFIG='
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ES2020",
    "moduleResolution": "Node",
    "esModuleInterop": true,
    "lib": ["DOM", "ES2020"],
    "jsx": "react",
    "strict": true,
    "sourceMap": true,
    "resolveJsonModule": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": "src"
  },
  "ts-node": {
    "compilerOptions": {
      "target": "ES2015",
      "module": "CommonJS"
    }
  },
  "include": ["src"]
}
'

echo "$TS_CONFIG" > ./tsconfig.json

EDITOR_CONFIG='
root = true
[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
[*.md]
trim_trailing_whitespace = false
'

echo "$EDITOR_CONFIG" > ./.editorconfig

ESLINT_RC='
{
  "env": {
    "es6": true,
    "node": true,
    "browser": true,
    "commonjs": true
  },
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2018,
    "ecmaFeatures": {
      "jsx": true
    },
    "sourceType": "module"
  },
  // React のバージョンは自動検出
  "settings": {
    "react": {
      "version": "detect"
    }
  },
  "plugins": ["react-hooks", "react", "@typescript-eslint"],
  // 基本的にルールは recommended に従う
  // prettier は配列の最後尾に書く
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/eslint-recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "prettier"
  ],
  "rules": {
    // TypeScript なので prop-types は要らない
    "react/prop-types": "off"
  }
}
'

echo "$ESLINT_RC" > ./.eslintrc.json

PRETTIER_RC='
{
  "singleQuote": true,
  "jsxBracketSameLine": true
}
'

echo "$PRETTIER_RC" > ./.prettierrc.json

echo "--- その他 設定 ---"
echo "１．VSCodeの拡張機能「eslint」「prettier」をインストールしてください"
echo "２．VSCodeでプロジェクトを開き、「Command + ,」で設定を開き、ワークスペースのsetting.jsonに下記を追記してください"
SETTING_JSON='
{
  "editor.formatOnSave": true,    // <-- prettierで整形
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true  // <-- eslintでリント
  },
  // デフォルトフォーマッタをprettierに
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
'
echo "$SETTING_JSON"
echo "３．必要であれば、package.jsonのscriptに追記してください"
PACKAGE_JSON='
"scripts": {
  "fix:eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
  "fix:prettier": "prettier --write ."
}
'
echo "$PACKAGE_JSON"

git add .
git commit -m "completed initialize.sh"

echo "以上で初期構築終了です。"
