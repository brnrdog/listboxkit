let options = ["Red", "Green", "Blue"]

@react.component
let make = () => {
  let {
    highlightedIndex,
    menuVisible,
    selectedIndex,
    getOptionProps,
    getDropdownProps,
    getContainerProps,
  } = Listboxkit.useDropdownListbox(options, ~multiSelect=false, ())

  let {role, tabIndex, onKeyDown, onFocus, onBlur} = getContainerProps()

  let dropdownProps = getDropdownProps()
  let selectedOption = selectedIndex === -1 ? "Select a color" : options[selectedIndex]

  <div>
    <div
      role=dropdownProps.role
      tabIndex=dropdownProps.tabIndex
      onClick=dropdownProps.onClick
      className="dropdown-button"
      onKeyDown=dropdownProps.onKeyDown>
      {selectedOption->React.string}
      <div className="dropdown">
        <ul className="listbox" role tabIndex onKeyDown onFocus onBlur hidden={!menuVisible}>
          {options
          ->Js.Array2.mapi((option, index) => {
            let {ariaSelected, onClick, role} = getOptionProps(index)
            let highlighted = highlightedIndex == index
            let className =
              ["listbox-option", highlighted ? "highlighted" : ""]->Js.Array2.joinWith(" ")

            <li className key=option onClick onKeyDown role ariaSelected>
              {option->React.string}
            </li>
          })
          ->React.array}
        </ul>
      </div>
    </div>
  </div>
}
