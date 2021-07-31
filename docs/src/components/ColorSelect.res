let options = ["Red", "Green", "Blue"]

@react.component
let make = (~multiSelect=false) => {
  let {highlightedIndex, getOptionProps, getContainerProps} = Listboxkit.useListbox(
    options,
    ~multiSelect,
    (),
  )

  let {role, tabIndex, onKeyDown, onFocus, onBlur} = getContainerProps()
  let listOption = (option, index) => {
    let {ariaSelected, onClick, role} = getOptionProps(index)
    let highlighted = highlightedIndex == index
    let className = ["listbox-option", highlighted ? "highlighted" : ""]->Js.Array2.joinWith(" ")

    <li className key=option onClick onKeyDown role ariaSelected> {option->React.string} </li>
  }

  <ul className="listbox" role tabIndex onKeyDown onFocus onBlur>
    {options->Js.Array2.mapi(listOption)->React.array}
  </ul>
}
