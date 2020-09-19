import React from "react";
import { useListbox } from "@brnrdog/listbox";

import "./index.css"

const options = [
  { text: "Walter W.", value: 0 },
  { text: "Jesse P.", value: 1 },
  { text: "Saul G.", value: 2 },
  { text: "Mike H.", value: 2 },
];

function App() {
  const {
    highlightedIndex,
    selectedIndex,
    getOptionProps,
  } = useListbox(options);

  return (
    <div className="container">
      <h1>Simple listbox example</h1>

      <ul className="listbox">
        {options.map((o, index) => {
          const selected = index === selectedIndex
          const highlighted = index === highlightedIndex

          const className = [
            "listbox-option",
            selected ? "active" : null,
            !selected && highlighted ? "highlighted" : null,
          ].filter(Boolean).join(" ")

          return (
            <li
              className={className}
              key={index}
              {...getOptionProps(index)}
            >
              {o.text}
            </li>
          );
        })}
      </ul>
    </div>
  );
}

export default App;
