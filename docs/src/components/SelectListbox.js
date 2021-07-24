import React from "react";
import { Dropdown } from "listboxkit";
import options from "./countries.json";

const labelId = "people-listbox";

function SelectListbox() {
  const {
    highlightedIndex,
    menuVisible,
    selectedIndex,
    getContainerProps,
    getDropdownProps,
    getOptionProps,
  } = Dropdown.useDropdownListbox(options, false);

  const selectedOption = options[selectedIndex];

  return (
    <div>
      <div className="dropdown-button" {...getDropdownProps()}>
        {selectedOption ? selectedOption.country : "Select a country"}
        <div className="dropdown">
          <ul
            hidden={!menuVisible}
            className="listbox"
            {...getContainerProps()}
          >
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
                  {o.country}
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    </div>
  );
}

export default SelectListbox;
