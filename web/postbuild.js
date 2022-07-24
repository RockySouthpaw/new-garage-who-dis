import path from 'path';
import fs from 'fs';

const src = path.resolve('../dist', 'index.html');
const index = fs.readFileSync(src, 'utf8').toString().replaceAll('"/', '"')
fs.writeFileSync(src, index);
console.log('Cleaned up index.html');