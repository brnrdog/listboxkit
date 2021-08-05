let onKeyDown = (
  ~hideMenu,
  ~highlightFirst,
  ~highlightLast,
  ~highlightNext,
  ~highlightPrev,
  ~menuVisible,
  ~selectHighlighted,
  ~selectNext,
  ~selectPrev,
  ~showMenu,
  event,
) => {
  let key = ReactEvent.Keyboard.key(event)
  let shiftKey = ReactEvent.Keyboard.shiftKey(event)

  if key != "Tab" {
    ReactEvent.Keyboard.preventDefault(event)
  }

  let selectCurrent = () => {
    selectHighlighted()
    hideMenu()
  }

  switch (key, menuVisible, shiftKey) {
  | ("ArrowDown", false, _)
  | ("ArrowUp", false, _)
  | ("Enter", false, _)
  | (" ", false, _) =>
    showMenu()
  | ("ArrowDown", true, false) => highlightNext()
  | ("ArrowDown", true, true) => selectNext()
  | ("ArrowUp", true, false) => highlightPrev()
  | ("ArrowUp", true, true) => selectPrev()
  | ("Enter", true, _)
  | (" ", true, _) =>
    selectCurrent()
  | ("Home", true, _) => highlightFirst()
  | ("End", true, _) => highlightLast()
  | ("Escape", true, _) => hideMenu()
  | _ => ()
  }
}

module Dom = {
  let isEventFromInside = %raw(`function (event) {
    return event.relatedTarget && event.target.contains(event.relatedTarget)
  }`)
}

let onBlur = (~resetHighlighted, ~hideMenu=?, ~menuVisible=?, event) => {
  let isFromInside = event->Dom.isEventFromInside
  switch (menuVisible, hideMenu, isFromInside) {
  | (Some(true), Some(hideMenu), false) => hideMenu()
  | _ => resetHighlighted()
  }
}

let onFocus = (~selectedIndexes, ~highlightIndex, _event) => {
  selectedIndexes
  ->Belt.Array.reverse
  ->Belt.Array.get(0)
  ->Belt.Option.getWithDefault(0)
  ->highlightIndex
}

let onClick = (~index, ~selectIndex, _event) => selectIndex(index)

let onDropdownClick = (~menuVisible, ~hideMenu, ~showMenu, _event) => {
  menuVisible ? hideMenu() : showMenu()
}
