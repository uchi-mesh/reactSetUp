# React 開発環境 初期構築手順

## 前準備

- node をインストールしておく

## 初期構築

- react アプリケーション雛形の作成
  - `npx create-react-app [任意のアプリ名]`
  - `--template typescript`を末尾につけると TypeScript のコードになる
  - `cd [任意のアプリ名]`
  - `npm start`

## eslint, prettier 設定

- `npm i -D eslint prettier eslint-config-prettier typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin @types/react @types/react-dom eslint-plugin-react eslint-plugin-react-hooks`
- tsconfig.json
  ```
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
      "forceConsistentCasingInFileNames": true
    },
    "ts-node": {
      "compilerOptions": {
        "target": "ES2015",
        "module": "CommonJS"
      }
    }
  }
  ```
- .eslintrc.json
  ```
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
  ```
- .prettierrc.json
  ```
  {
    "singleQuote": true,
    "jsxBracketSameLine": true
  }
  ```
- vscode の ESLint, Prettier 拡張機能をインストール
- .vscode/settings.json を編集
  ```
  {
    "editor.formatOnSave": true,    // <-- prettierで整形
    "editor.codeActionsOnSave": {
      "source.fixAll.eslint": true  // <-- eslintでリント
    },
    // デフォルトフォーマッタをprettierに
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
  ```
- package.json

  ```
  {
    "scripts": {
      "fix:eslint": "eslint . --ext .js,.ts,.jsx,.tsx --fix",
      "fix:prettier": "prettier --write ."
    }
  }
  ```

## .editorconfig

```
# EditorConfig helps developers define and maintain consistent
# coding styles between different editors and IDEs
# editorconfig.org

root = true


[*]

# Change these settings to your own preference
indent_style = space
indent_size = 2

# We recommend you to keep these unchanged
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false
```

## import を絶対パス表記

- tsconfig.json

```
"compilerOptions": {
  "baseUrl": "src"
},
"include": ["src"]
```

- 参考サイト様
  - [VSCode + ESLint + Prettier + React + TypeScript （Fall, 2020）](https://zenn.dev/sprout2000/articles/9f20902d394aa2)
  - [import する際に絶対パスで書きたい](https://qiita.com/10mi8o/items/326e1535451e57dbb12f)
