({
 
    // Define our base URL - all module paths are relative to this
    // base directory.
    baseUrl: "server/frontend/static/webappjs/search",
 
    // Define our build directory. All files in the base URL will be
    // COPIED OVER into the build directory as part of the
    // concatentation and optimization process. You should use this
    // so you don't override your raw source files.
    dir: "server/frontend/static/build/search",
 
    // Load the RequireJS config() definition from the main.js file.
    // Otherwise, we'd have to redefine all of our paths again here.
    mainConfigFile: "server/frontend/static/webappjs/search/app.js",
    
    // Define the modules to compile.
    modules: [
 
        // When compiling the main file, don't include the FAQ module.
        // We want to lazy-load FAQ since it probably won't be used
        // very much.
        {
            name: "app",
 
            // Explicitly include modules that are NOT required
            // directly by the MAIN module. This allows us to include
            // commonly used modules that we want to front-load.
            include: [
                "lib/require.js"
            ]
 
            // Use the *shallow* exclude; otherwise, dependencies of
            // the FAQ module will also be excluded from this build
            // (including jQuery and text and util modules). In other
            // words, a deep-exclude would override our above include.

	    // If we don't exclude these modules, they will be doubly
            // defined in our main module (since these are ALSO
            // dependencies of our main module).
            /*exclude: [
                "jquery",
                "underscore",
                "backbone"
            ] */
        }
    ],
 
    // Turn off UglifyJS so that we can view the compiled source
    // files (in order to make sure that we know that the compile
    // is working properly - for debugging only.)
    optimize: "none"
 
})
