const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

module.exports = {
  mode: "development",
  context: path.resolve(__dirname, "assets"),
  output: {
    filename: "main.bundle.js",
    path: path.resolve(__dirname, "public/assets"),
    publicPath: 'http://localhost/assets/', // needed for webpack-dev-server
  },
  watchOptions: {
    aggregateTimeout: 300,
    poll: 1000,
  },
  devServer: {
    host: '0.0.0.0', // needed for docker
    port: '3000', // this must match the 2nd exposed port in the docker-compose.yml file
    hot: true,
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    watchFiles: {
      paths: ['public/**/*'],
      options: {
        usePolling: true,
      }
    },
  },
  // watch: true,
  plugins: [
    new MiniCssExtractPlugin(),
  ],
  module: {
    rules: [{
      test: /\.css$/,
      use: [
        MiniCssExtractPlugin.loader,
        {
          loader: 'css-loader',
          options: {
            importLoaders: 1
          }
        },
        {
          loader: 'postcss-loader',
          options: {
            postcssOptions: {
              plugins: [
                require('tailwindcss'),
                require('autoprefixer')
              ]
            }
          }
        }
      ]
    }]
  }
}
