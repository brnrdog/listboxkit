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

  let selectCurrent = () => {
    selectHighlighted()
    hideMenu()
  }

  switch (key, menuOpen) {
  | ("ArrowDown", false) 
  | ("ArrowUp",   false) 
  | ("Enter",     false) 
  | (" ",         false) => showMenu()
  | ("ArrowDown", true)  => highlightNext()
  | ("ArrowUp",   true)  => highlightPrev()
  | ("Enter",     true) 
  | (" ",         true)  => selectCurrent()
  | ("Home",      true)  => highlightFirst()
  | ("End",       true)  => highlightLast()
  | ("Escape",    true)  => hideMenu()
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