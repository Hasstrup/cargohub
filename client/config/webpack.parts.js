
exports.devServer = ({ host, port }) => ({
    devServer: {
      host,
      port,
      open: 'Google Chrome',
      overlay: true,
      hotOnly: true, 
      historyApiFallback: true
    }
  });
  
  exports.loadFonts = () => {
    return {
      module: {
        rules: [
          {
            test: /\.(ttf|eot|woff|woff2|otf)$/,
            use: {
              loader: 'file-loader',
              options: {
                name: 'fonts/[name].[ext]',
              },
            }
          }
        ]
      }
    };
  };
  
  exports.loadJavascript = () => {
    return {
      module: {
        rules: [
          {
            test: /\.(js|jsx)$/,
            exclude: /node_modules/,
            use: [
              {
                loader: 'babel-loader',
                options: {
                  presets: ['env', 'react'],
                  plugins: ['react-hot-loader/babel',
                    'transform-class-properties',
                    'transform-object-rest-spread',
                    'transform-es2015-arrow-functions'
                  ]
                }
              }
            ],
          }
        ]
      }
    };
  };
  
  exports.lintJavascript = () => {
    return {
      module: {
        rules: [
          {
            test: /\.(js|jsx)$/,
            enforce: 'pre',
            exclude: /node_modules/,
            loader: 'eslint-loader',
            options: {
                failOnError: false
              }
          }
        ]
      }
    };
  };
  
  exports.LoadCSS = () => {
    return {
      module: {
        rules: [
          {
            test: /\.css$/,
            use: ['style-loader', 'css-loader']
          },
          {
            test: /\.scss$/,
            use: ['style-loader', 'css-loader', 'sass-loader'],
          }
        ]
      }
    };
  };