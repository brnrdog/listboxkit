let onKeyDown = (
  ~hideMenu,
  ~showMenu,
  ~menuVisible,
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

  switch (key, menuVisible) {
  | ("ArrowDown", false) | ("ArrowUp", false) | ("Enter", false) | (" ", false) => showMenu()
  | ("ArrowDown", true) => highlightNext()
  | ("ArrowUp", true) => highlightPrev()
  | ("Enter", true) | (" ", true) => selectCurrent()
  | ("Home", true) => highlightFirst()
  | ("End", true) => highlightLast()
  | ("Escape", true) => hideMenu()
  | _ => ()
  }
}

let onClick = (~index, ~selectIndex, _event) => selectIndex(index)
