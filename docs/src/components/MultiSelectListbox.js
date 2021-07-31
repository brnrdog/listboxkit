import React from "react";
import { useListbox } from "listboxkit";
import options from "./countries.json";

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

function MultiSelectListbox() {
  const {
    highlightedIndex,
    selectedIndexes,
    selectedIndex,
    getOptionProps,
    getContainerProps,
  } = useListbox(options, true);

  return (
    <div style={{ display: "flex" }}>
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
      </div>
      <div style={{ padding: "1rem" }}>
        <label className="label">You have selected:</label>
        <div className="example-selected">
          {selectedIndexes?.length ? (
            <>
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
    </div>
  );
}

export default MultiSelectListbox;
