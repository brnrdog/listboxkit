@react.component
let make = (
  ~activeClassName=?,
  ~className=?,
  ~multiSelect=false,
  ~onChange=?,
  ~optionClassName=?,
  ~options,
) => {
  let {highlightedIndex, getOptionProps, getContainerProps} = Listboxkit__Listbox.useListbox(
    options,
    ~multiSelect,
    ~onChange=Belt.Option.getExn(onChange),
    (),
  )
  let {role, tabIndex, onKeyDown, onFocus, onBlur} = getContainerProps()

  let listOption = (option, index) => {
    let {ariaSelected, onClick, role} = getOptionProps(index)
    let highlighted = highlightedIndex == index
    let className =
      [optionClassName, highlighted ? activeClassName : None]
      ->Js.Array2.joinWith(" ")
      ->Js.String.trim

    <li className key=option onClick onKeyDown role ariaSelected> {option->React.string} </li>
  }

  let className = className->Belt.Option.getUnsafe

  <ul className role tabIndex onKeyDown onFocus onBlur>
    {options->Js.Array2.mapi(listOption)->React.array}
  </ul>
}
