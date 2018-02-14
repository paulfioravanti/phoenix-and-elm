// NOTE: When bringing in Elm-Phoenix, the example app within the package
// causes havoc with styling etc, so the best thing to do is remove it ie
// rm -rf assets/elm/elm-stuff/packages/saschatimme/elm-phoenix/example
// See: https://github.com/saschatimme/elm-phoenix/issues/7
exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor", "elm"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    stylus: {
      plugins: ["nib"]
    },
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
      // ignore: [/web\/static\/vendor/]
    },

    elmBrunch: {
      elmFolder: "elm",
      mainModules: ["src/Main.elm"],
      // NOTE: outputFolder is in vendor to ensure that elm.js gets
      // compiled/imported before app.js.
      // Originally wanted to have elm.js be in the js/ directory, but
      // order concatenations in the config above don't seem to be working,
      // and vendor files are guaranteed to be compiled before other ones
      // http://brunch.io/docs/config#-files-
      // outputFolder: "../vendor",
      outputFolder: "../js",
      outputFile: "elm.js",
      makeParameters: [
        "--debug"
        // "--warn"
      ]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
    styles: {
      'normalize.css': ['normalize.css'],
    }
  }
};
