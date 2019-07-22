const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.loaders.append('vue', vue)
environment.plugins.append('VueLoaderPlugin', new VueLoaderPlugin())


environment.loaders.prepend('vue', vue)
module.exports = {
  module: {
    rules: [
      // ... other rules
      {
        test: /\.vue/,
        loader: 'vue-loader'
      }
    ]
  },
  plugins: [
    // make sure to include the plugin!
    new VueLoaderPlugin()
  ]
}

environment.loaders.prepend('vue', vue)
module.exports = environment
