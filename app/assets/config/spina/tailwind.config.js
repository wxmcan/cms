module.exports = {
  content: [
    '/Users/guotong/.rbenv/versions/3.1.3/lib/ruby/gems/3.1.0/gems/spina-2.14.0/app/views/**/*.*',
'/Users/guotong/.rbenv/versions/3.1.3/lib/ruby/gems/3.1.0/gems/spina-2.14.0/app/components/**/*.*',
'/Users/guotong/.rbenv/versions/3.1.3/lib/ruby/gems/3.1.0/gems/spina-2.14.0/app/helpers/**/*.*',
'/Users/guotong/.rbenv/versions/3.1.3/lib/ruby/gems/3.1.0/gems/spina-2.14.0/app/assets/javascripts/**/*.js',
'/Users/guotong/.rbenv/versions/3.1.3/lib/ruby/gems/3.1.0/gems/spina-2.14.0/app/**/application.tailwind.css'
  ],
  theme: {
    fontFamily: {
      body: ['Metropolis'],
      mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", 'monospace']
    },
    extend: {
      colors: {
        spina: {
          light: '#797ab8',
          DEFAULT: '#6865b4',
          dark: '#3a3a70'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
	require('@tailwindcss/aspect-ratio'),
	require('@tailwindcss/typography')
  ]
}
