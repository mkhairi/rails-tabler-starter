#!/usr/bin/env node

import * as esbuild from 'esbuild'
import { copy } from 'esbuild-plugin-copy'
import rails from 'esbuild-rails'
import path from 'path'
import { sassPlugin } from 'esbuild-sass-plugin'

const config = {
  entryPoints: [
    'javascripts/application.js',
    'stylesheets/application.scss'
  ],
  bundle: true,
  sourcemap: process.argv.includes('--sourcemap'),
  //resolveExtensions: ['.ts', '.js'],
  logLevel: 'info',
  outdir: 'builds',
  outbase: path.join(process.cwd(), 'app/assets'),
  absWorkingDir: path.join(process.cwd(), 'app/assets'),
  metafile: true,
  entryNames: '[name]',
  minify: process.env.RAILS_ENV == 'production',
  //external: ['*.css', '*.woff', '*.png', '*.svg'],
  loader: {
    '.jpeg': 'file',
    '.png': 'file',
    '.woff': 'dataurl',
    '.woff2': 'dataurl',
    '.eot': 'dataurl',
    '.ttf': 'dataurl',
    '.svg': 'file'
  },
  define: {
    'process.env.RELEASE_STAGE': JSON.stringify(
      process.env.RAILS_ENV || 'production'
    ),
    'process.env.BUILD_AT': JSON.stringify(process.env.BUILD_AT || Date.now()),
    global: 'window'
  },
  // platform: 'node',
  plugins: [
    rails(),
    copy({
      resolveFrom: path.join(process.cwd(), 'public/assets'),
      assets: [
        {
          from: [
            './node_modules/tinymce/**/*.js',
            './node_modules/tinymce/**/*.css'
          ],
          to: ['./tinymce'],
          keepStructure: true
        }
      ]
    }),
    sassPlugin()
  ]
}

if (process.argv.includes('--watch')) {
  let context = await esbuild.context({ ...config, logLevel: 'info' })
  console.log(
    `⚡ Build node esbuild for ${process.env.RAILS_ENV} complete! ⚡, watching...`
  )
  context.watch()
} else {
  esbuild.build(config).catch(error => {
    console.error(error)
    process.exit(1)
  })
  console.log(`⚡ Build node esbuild for ${process.env.RAILS_ENV} complete! ⚡`)
}
