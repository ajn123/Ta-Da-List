const { dev_server: devServer } = require('@rails/webpacker').config

const isProduction = process.env.NODE_ENV === 'production'
const inDevServer = process.argv.find(v => v.includes('webpack-dev-server'))
const extractCSS = !(inDevServer && (devServer && devServer.hmr)) || isProduction


// config/webpack/loaders/vue.js
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const { VueLoaderPlugin } = require('vue-loader')

environment.plugins.append('VueLoaderPlugin',
  new VueLoaderPlugin()
);

