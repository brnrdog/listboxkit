type inputProps = {ariaLabelledby: string}

type labelProps = {id: string}

type toggleProps = {
  ariaLabelledby: string,
  tabIndex: int,
  onClick: ReactEvent.Mouse.t => unit,
  onKeyDown: ReactEvent.Keyboard.t => unit,
  onBlur: ReactEvent.Focus.t => unit,
}

type menuProps = {ariaLabelledby: string}

type optionProps = {
  role: string,
  ariaSelected: bool,
  onClick: ReactEvent.Mouse.t => unit,
}

type selectConfiguration = {
  selectedIndex: int,
  highlightedIndex: int,
  menuOpen: bool,
  getToggleProps: unit => toggleProps,
  getLabelProps: unit => labelProps,
  getMenuProps: unit => menuProps,
  getOptionProps: int => optionProps,
  showMenu: unit => unit,
  hideMenu: unit => unit,
}

module Toggle = {
  let onKeyDown = (
    ~hideMenu,
    ~showMenu,
    ~menuOpen,
    ~highlightNext,
    ~highlightPrev,
    ~highlightFirst,
    ~highlightLast,
    ~selectHighlighted,
    event,
  ) => {
    ReactEvent.Keyboard.preventDefault(event)

    let key = ReactEvent.Keyboard.key(event)

    switch (key, menuOpen) {
    | ("ArrowDown", false) | ("ArrowUp", false) | ("Enter", false) | (" ", false) => showMenu()
    | ("ArrowDown", true) => highlightNext()
    | ("ArrowUp", true) => highlightPrev()
    | ("Enter", true) | (" ", true) => {
        selectHighlighted()
        hideMenu()
      }
    | ("Home", true) => highlightFirst()
    | ("End", true) => highlightLast()
    | ("Escape", true) => hideMenu()
    | _ => ()
    }
  }

  let onClick = (~showMenu, event) => {
    ReactEvent.Mouse.preventDefault(event)
    showMenu()
  }

  let onBlur = (~hideMenu, event) => {
    ReactEvent.Focus.preventDefault(event)
    hideMenu()
  }
}

let useDropdownSelect = (~labelId=?, ~options) => {
  let size = Belt.Array.length(options)
  let (menuOpen, setMenuOpen) = React.useState(() => false)
  let (highlightedIndex, setHighlightedIndex) = React.useState(() => -1)
  let (selectedIndex, setSelectedIndex) = React.useState(() => -1)

  let showMenu = () => setMenuOpen(_ => true)
  let hideMenu = () => setMenuOpen(_ => false)

  let highlightNext = () => setHighlightedIndex(index => {
      size - index == 1 ? 0 : index + 1
    })
  let highlightPrev = () => setHighlightedIndex(index => {
      index == 0 ? Belt.Array.length(options) - 1 : index - 1
    })
  let selectHighlighted = () => setSelectedIndex(_ => highlightedIndex)
  let highlightFirst = _ => setHighlightedIndex(_ => 0)
  let highlightLast = _ => setHighlightedIndex(_ => size - 1)

  let getLabelProps = () => {
    id: Belt.Option.getUnsafe(labelId),
  }

  let getToggleProps = () => {
    ariaLabelledby: Belt.Option.getUnsafe(labelId),
    onClick: Toggle.onClick(~showMenu),
    onKeyDown: Toggle.onKeyDown(
      ~hideMenu,
      ~showMenu,
      ~menuOpen,
      ~highlightNext,
      ~highlightPrev,
      ~highlightFirst,
      ~highlightLast,
      ~selectHighlighted,
    ),
    onBlur: Toggle.onBlur(~hideMenu),
    tabIndex: 0,
  }

  let getMenuProps: unit => menuProps = () => {
    ariaLabelledby: Belt.Option.getUnsafe(labelId),
  }

  let getOptionProps = index => {
    role: "option",
    ariaSelected: index == selectedIndex,
    onClick: _event => {
      setSelectedIndex(_ => index)
    },
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
