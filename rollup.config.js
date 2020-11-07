import commonjs from '@rollup/plugin-commonjs';
import { terser } from "rollup-plugin-terser";


export default {
  input: 'src/Listbox.bs.js',
  output: [
    {
      file: 'dist/listbox.cjs.js',
      format: 'cjs',
    },
    {
      file: 'dist/listbox.esm.js',
      format: 'esm',
    }
  ],
  plugins: [commonjs(), terser()]
};
