/** @type {import('tailwindcss').Config} */
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      borderWidth: {
        '1': '1px',
      },
      spacing: {
        '112':'28rem',
        '128': '32rem',
      },
      fontFamily: {
        'sans': ['"Amazon Ember"', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'amber': '#ff9900',
        'amazon': '#232f3e',
        'azure': '#146eb4'
      }
    },
  },
  plugins: [],
}

