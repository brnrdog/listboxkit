import commonjs from "@rollup/plugin-commonjs";
import { terser } from "rollup-plugin-terser";
import analyze from "rollup-plugin-analyzer";

export default {
  input: "src/Listboxkit.bs.js",
  output: [
    {
      file: "dist/listboxkit.cjs.js",
      format: "cjs",
    },
    {
      file: "dist/listboxkit.esm.js",
      format: "esm",
    },
  ],
  plugins: [commonjs(), terser(), analyze()],
};
