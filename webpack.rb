# frozen_string_literal: true

# creating a new instance of this class
# will create a basic skeleton for webpack
# with css, hmtl, image
# uses system calls (touch, npm, git),
# ruby methods,
# and vim for file editing
class SetupWebpack
  INDEX_PATH = 'src/index.js'
  INDEX =
    "import './style.css';

    function component() {
      const element = document.createElement('div');

      return element;
    }

    document.body.appendChild(component());"
  WEBPACKCONFIG_PATH = 'webpack.config.js'
  WEBPACKCONFIG =
    "const path = require('path');
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
        ],
      },
    };"

  def initialize
    basic_start
    add_css_html_plugins
    git_init
    add_dotenv
    create_config_file
    add_npm_build_watch
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
end

SetupWebpack.new
