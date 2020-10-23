import React from "react";
import { useListbox } from "@brnrdog/listbox";
import options from './countries.json'

const labelId = "people-listbox";

const Checkbox = () => {
  return (
    <div className="checkbox">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
        <path
          fill="#030104"
          d="M11.941 28.877L0 16.935l5.695-5.695 6.246 6.246L26.305 3.123 32 8.818z"
        />
      </svg>
    </div>
  );
};

function Listbox() {
  const {
    highlightedIndex,
    selectedIndexes,
    getOptionProps,
    getContainerProps,
  } = useListbox(options);

  return (
    <div>
      <label className="label" id={labelId}>
        Select a country:
      </label>
      <ul className="listbox" {...getContainerProps()}>
        {options.map((o, index) => {
          const optionProps = getOptionProps(index);
          const highlighted = index === highlightedIndex;

          const className = [
            "listbox-option",
            highlighted ? "highlighted" : null,
          ]
            .filter(Boolean)
            .join(" ");

          return (
            <li className={className} key={index} {...optionProps}>
              <Checkbox checked={selectedIndexes.includes(index)} />
              {o.country}
            </li>
          );
        })}
      </ul>
      <div className="example-selected">
        {selectedIndexes.length ? (
          <>
            You have selected:
            {selectedIndexes.map((i, index) => (
              <div key={index} className="tag">
                {options[i].abbreviation}
              </div>
            ))}
          </>
        ) : (
          "You have not selected any country."
        )}
      </div>
    </div>
  );
}

export default Listbox;
