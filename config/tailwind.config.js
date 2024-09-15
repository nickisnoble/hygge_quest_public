const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      screens: {
        xs: "400px"
      },
      fontFamily: {
        sans:    ['Inter var', ...defaultTheme.fontFamily.sans],
        serif:   ["adobe-jenson-pro", ...defaultTheme.fontFamily.serif],
        display: ["adobe-jenson-pro-display", ...defaultTheme.fontFamily.serif],
        caption: ["adobe-jenson-pro-caption", ...defaultTheme.fontFamily.serif],
        hand:    ["rollerscript-rough", ...defaultTheme.fontFamily.serif],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
