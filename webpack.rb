# frozen_string_literal: true

module Constants
  INDEX_PATH = 'src/index.js'
  INDEX = <<-HTML
    import './style.css';

    function component() {
      const element = document.createElement('div');

      return element;
    }

    document.body.appendChild(component());
  HTML

  WEBPACKCONFIG_PATH = 'webpack.config.js'
  WEBPACKCONFIG = <<-WEBPACK
    const path = require('path');
    const HtmlWebpackPlugin = require('html-webpack-plugin');
    const Dotenv = require('dotenv-webpack');

    module.exports = {
      entry: './src/index.js',
      plugins: [
        new HtmlWebpackPlugin({
          title: 'MyApp',
        }),
        new Dotenv(),
      ],
      output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'dist'),
        clean: true,
      },
      module: {
        rules: [
          {
            test: /\.css$/i,
            use: ['style-loader', 'css-loader'],
          },
          {
            test: /\.(png|svg|jpg|jpeg|gif)$/i,
            type: 'asset/resource',
          },
          {
            test: /\.m?js$/,
            exclude: /node_modules/,
            use: {
              loader: 'babel-loader',
              options: {
                presets: [
                  ['@babel/preset-env', { targets: 'defaults' }]
                ]
              }
            }
          }
        ],
      },
    };
  WEBPACK

  BABELRC = <<-BABEL
    {
      "presets": [["env", {"modules": false}]],

      "plugins": ["syntax-dynamic-import"],

      "env": {
        "test": {
          "plugins": ["dynamic-import-node"]
        }
      }
    }
  BABEL

  JESTPACKAGE = <<-JSON
    "jest": {
      "moduleFileExtensions": ["js", "jsx"],
      "moduleDirectories": ["node_modules", "bower_components", "shared"],
      "moduleNameMapper": {
        "\\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$": "<rootDir>/__mocks__/fileMock.js",
        "\\\.(css|less)$": "identity-obj-proxy"
      }
    }
  JSON
end

# creating a new instance of this class
# will create a basic skeleton for webpack
# with css, hmtl, image
# babel, jest
# uses system calls (touch, npm, git),
# ruby methods,
# and vim for file editing
class SetupWebpack
  include Constants

  def initialize
    basic_start
    add_css_html_plugins
    git_init
    add_dotenv
    create_config_file
    system('npm install -D babel-loader @babel/core @babel/preset-env webpack')
    add_npm_build_watch
    add_jest
  end

  def basic_start
    system('npm init -y')
    system('npm install webpack webpack-cli --save-dev')
    Dir.mkdir('dist')
    Dir.mkdir('src')
    system("touch #{INDEX_PATH}")
    File.open(INDEX_PATH, 'w') { |file| file.write(INDEX) }
    replace_line_package_json
  end

  def add_css_html_plugins
    system('npm install --save-dev style-loader css-loader')
    system('touch src/style.css')
    system('npm install --save-dev html-webpack-plugin')
  end

  def replace_line_package_json
    file = File.read('package.json')
    new_content = file.gsub('"main": "index.js",', '"private": true,')
    File.open('package.json', 'w') { |line| line.puts new_content }
  end

  def create_config_file
    system("touch #{WEBPACKCONFIG_PATH}")
    File.open(WEBPACKCONFIG_PATH, 'w') { |file| file.write(WEBPACKCONFIG) }
  end

  def git_init
    system('git init')
    system('touch .gitignore')
    File.open('.gitignore', 'w') { |file| file.write('node_modules/') }
  end

  def add_dotenv
    system('npm install dotenv-webpack --save-dev')
    system('touch .env')
    File.open('.env', 'w') { |file| file.write('// KEY=secret') }
    File.open('.gitignore', 'a') { |file| file.write("\n.env") }
  end

  def add_npm_build_watch
    system('vim -c "7 s/$/,\r\t\"watch\": \"webpack --watch\"/" -c "wq" package.json')
    system('vim -c "8 s/$/,\r\t\"build\": \"webpack\"/" -c "wq" package.json')
  end

  def add_jest
    system('npm install --save-dev jest')
    system('npm install --save-dev identity-obj-proxy')
    Dir.mkdir('__mocks__')
    system('touch __mocks__/fileMock.js')
    filemock = "module.exports = 'test-file-stub';"
    File.open('__mocks__/fileMock.js', 'w') { |file| file.write(filemock) }
    system('touch .babelrc')
    File.open('.babelrc', 'w') { |file| file.write(BABELRC) }
    puts 'please update the test command to "jest" and add the following to your package.json:'
    puts JESTPACKAGE
  end
end

SetupWebpack.new
