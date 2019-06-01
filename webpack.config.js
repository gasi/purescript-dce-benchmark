module.exports = {
  mode: 'production',
  optimization: {
    // minimize: false,
    usedExports: true,
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        sideEffects: false,
      }
    ]
  }
};