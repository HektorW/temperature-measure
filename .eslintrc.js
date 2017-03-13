module.exports = {
  "parser": "babel-eslint",
  "env": {
    "es6": true,
    "node": true,
  },
  "extends": "eslint:recommended",
    "rules": {
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "quotes": ["error", "single"],
    "semi": ["error", "never"],
    "generator-star-spacing": ["error", "after"],
    "comma-dangle": ["error", "always-multiline"],
    "require-yield": 0,
  }
};
