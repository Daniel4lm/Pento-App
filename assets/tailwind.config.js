// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const colors = require('tailwindcss/colors');
const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
  ],
  theme: {
    extend: {
      colors: {
        'light-blue': colors.sky,
        cyan: colors.cyan,
      },
      fontSize: {
        1: '1em',
        1.1: '1.1em',
        1.2: '1.2em',
        1.4: '1.4em',
        1.6: '1.6em',
        2: '2em',
      },
      fontFamily: {
        ubuntu: ['Ubuntu', ...defaultTheme.fontFamily.sans],
        nunitoSans: ['Nunito Sans', ...defaultTheme.fontFamily.sans],
        ptSans: ['PT Sans', ...defaultTheme.fontFamily.sans],
        quickSand: ['Quicksand', ...defaultTheme.fontFamily.sans],
        roboto: ['Roboto', ...defaultTheme.fontFamily.sans],
      },
      /* Responsive breakpoints */
      screens: {
        //mobile: '375px',
        // => @media (min-width: 375px) { ... }
        //tablet: '768px',
        // => @media (min-width: 768px) { ... }
        //tablet2: '900px',
        // => @media (min-width: 900px) { ... }
        //desktop: '1440px',
        // => @media (min-width: 1440px) { ... }
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
