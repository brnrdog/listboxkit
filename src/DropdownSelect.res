open Belt;

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
  role: string,
  ariaSelected: bool,
  onClick: ReactEvent.Mouse.t => unit,
}

type selectConfiguration = {
  selectedIndex   : int,
  highlightedIndex: int,
  menuOpen        : bool,
  getToggleProps  : unit => toggleProps,
  getLabelProps   : unit => labelProps,
  getMenuProps    : unit => menuProps,
  getOptionProps  : int  => optionProps,
  showMenu        : unit => unit,
  hideMenu        : unit => unit,
}

let nextIndex = (~size, index) => size - index == 1 ? 0 : index + 1
let prevIndex = (~size, index) => index == 0 ? size - 1 : index - 1 

let useDropdownSelect = (~labelId=?, ~options) => {
  let (menuOpen, setMenuOpen)                 = React.useState(() => false)
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)
  let (selectedIndex, setSelectedIndex)       = React.useState(() => -1)

  let size = Array.length(options)
  let labelId = labelId |> Option.getUnsafe

  let highlightNext     = ()    => setHighlightedIndex(nextIndex(~size))
  let highlightPrev     = ()    => setHighlightedIndex(prevIndex(~size))
  let showMenu          = ()    => setMenuOpen(_ => true)
  let hideMenu          = ()    => setMenuOpen(_ => false)
  let selectIndex       = index => setSelectedIndex(_ => index)
  let selectHighlighted = ()    => setSelectedIndex(_ => highlightedIndex)
  let highlightFirst    = _     => setHighlightedIndex(_ => 0)
  let highlightLast     = _     => setHighlightedIndex(_ => size - 1)

  let getLabelProps = () => {
    id: labelId
  }

  let getToggleProps = () => {
    ariaLabelledby: labelId,
    onClick: ToggleProps.onClick(~showMenu),
    onKeyDown: ToggleProps.onKeyDown(
      ~hideMenu,
      ~showMenu,
      ~menuOpen,
      ~highlightNext,
      ~highlightPrev,
      ~highlightFirst,
      ~highlightLast,
      ~selectHighlighted,
    ),
    onBlur: ToggleProps.onBlur(~hideMenu),
    tabIndex: 0,
  }

  let getMenuProps: unit => menuProps = () => {
    ariaLabelledby: labelId,
  }

  let getOptionProps = index => {
    role: "option",
    ariaSelected: OptionProps.ariaSelected(~index, ~selectedIndex),
    onClick: OptionProps.onClick(~index, ~selectIndex),
  }

  {
    selectedIndex: selectedIndex,
    highlightedIndex: highlightedIndex,
    menuOpen: menuOpen,
    getToggleProps: getToggleProps,
    getLabelProps: getLabelProps,
    getMenuProps: getMenuProps,
    getOptionProps: getOptionProps,
    showMenu: showMenu,
    hideMenu: hideMenu,
  }
}
