type inputProps = {
  ariaLabelledby: string
}

type labelProps = {
  id: string
}

type toggleProps = {
  ariaLabelledby: string,
  tabIndex      : int,
  onClick       : ReactEvent.Mouse.t => unit,
  onKeyDown     : ReactEvent.Keyboard.t => unit,
  onBlur        : ReactEvent.Focus.t => unit,
}

type menuProps = {
  ariaLabelledby: string
}

type optionProps = {
  role        : string,
  ariaSelected: bool,
  onClick     : ReactEvent.Mouse.t => unit,
}

type dropdownListbox = {
  selectedIndex   : int,
  highlightedIndex: int,
  menuVisible     : bool,
  getToggleProps  : unit => toggleProps,
  getLabelProps   : unit => labelProps,
  getMenuProps    : unit => menuProps,
  getOptionProps  : int => optionProps,
  showMenu        : unit => unit,
  hideMenu        : unit => unit,
}

let useDropdownListbox: (
  ~labelId: string=?, 
  ~options: array<'a>
) => dropdownListbox
