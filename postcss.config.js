module.exports = {
    plugins: [
        // require('postcss-each-variables')({}),
        // require('postcss-at-rules-variables')({}),
        require('postcss-import'),
        require('postcss-each')({}),
        require('postcss-for')({}),
        // require('postcss-preset-env')({ stage: 1, }),
        require('postcss-nested')({}),
        require('postcss-conditionals')({}),
        require('postcss-custom-media')({}),
        require('postcss-media-minmax')({}),
        require('postcss-mixins')({}),
        require('rucksack-css')({}),
        require('css-mqpacker')({}),
        require('autoprefixer')({
            // overrideBrowserslist: [
                // "BlackBerry >= 7",
                // "Chrome >= 9",
                // "Firefox >= 4",
                // "Explorer >= 9",
                // "iOS >= 7",
                // "Safari >= 6",
                // "ExplorerMobile >= 9"
            // ]
        }),
        require('postcss-discard-comments')({}),
        // require('cssnano')({}),
    ],
};