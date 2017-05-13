const fs = require('fs');
const pascalCase = require('change-case').pascalCase;

const components = require('glob').sync('./src/**/*.vue').reduce((a, path) => {
  const name = pascalCase(path.split('/').pop().split('.').shift());
  a.push({
    path: path.replace('src/es/', ''),
    name,
  });
  return a;
}, []);

const componentRequirement = components.reduce((a, { path, name }) => {
    a[0].push(`export const ${name} = require('${path}');`);

    if (name.indexOf('Context') === -1) {
      a[1].push(`Vue.component('${name}', ${name});`);
    }

    return a;
  }
  , [[], []]).map(p => p.join('\n')).join('\n');

fs.writeFileSync('./src/es/all-components.js', `import Vue from 'vue';\n\n// This file was generated automatically.\n\n${componentRequirement}\n`);
