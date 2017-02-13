var path = require("path");

module.exports = {
    module: {
        loaders: [
            {
                test: /\.tsx?$/,
                exclude: /(node_modules)/,
                loader: "ts"
            }
        ]
    }, entry: {
        "main": "./web/index.tsx",
        "who": "./web/who.tsx"
    }, output: {
        filename: "[name].bundle.js",
        path: __dirname + "/public"
    }
    , resolve: {
        extensions: ['', '.js', '.ts', '.tsx', '.hbs'],
        fallback: path.join(__dirname, 'node_modules')
    }
    , devServer: {
        historyApiFallback: {
            index: '/index.html',
            rewrites: [
                { from: /\/app\//, to: '/app/index.html' }
            ]
        },
    }
};
