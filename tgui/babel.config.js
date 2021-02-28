/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

const createBabelConfig = options => {
  const { mode, presets = [], plugins = [] } = options;
  return {
    presets: [
<<<<<<< HEAD
      ['@babel/preset-env', {
=======
      [require.resolve('@babel/preset-typescript'), {
        allowDeclareFields: true,
      }],
      [require.resolve('@babel/preset-env'), {
>>>>>>> 21d5a65346c (Fix a number of build issues (#57251))
        modules: 'commonjs',
        useBuiltIns: 'entry',
        corejs: '3.8',
        spec: false,
        loose: true,
        targets: [],
      }],
      ...presets,
    ],
    plugins: [
<<<<<<< HEAD
      '@babel/plugin-transform-jscript',
      'babel-plugin-inferno',
      'babel-plugin-transform-remove-console',
      'common/string.babel-plugin.cjs',
=======
      [require.resolve('@babel/plugin-proposal-class-properties'), {
        loose: true,
      }],
      require.resolve('@babel/plugin-transform-jscript'),
      require.resolve('babel-plugin-inferno'),
      require.resolve('babel-plugin-transform-remove-console'),
      require.resolve('common/string.babel-plugin.cjs'),
>>>>>>> 21d5a65346c (Fix a number of build issues (#57251))
      ...plugins,
    ],
  };
};

module.exports = (api) => {
  api.cache(true);
  const mode = process.env.NODE_ENV;
  return createBabelConfig({ mode });
};

module.exports.createBabelConfig = createBabelConfig;
