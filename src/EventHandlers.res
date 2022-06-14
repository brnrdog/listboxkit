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
  ~highlightFirstOnOpen=false,
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

  switch (key, menuVisible, shiftKey, highlightFirstOnOpen) {
  | ("ArrowDown", false, _, false)
  | ("ArrowUp", false, _, false)
  | ("Enter", false, _, false)
  | (" ", false, _, false) =>
    showMenu()
  | ("ArrowDown", false, _, true)
  | ("ArrowUp", false, _, true)
  | ("Enter", false, _, true)
  | (" ", false, _, true) =>
    showMenu()
    highlightFirst()
  | ("ArrowDown", true, false, _) => highlightNext()
  | ("ArrowDown", true, true, _) => selectNext()
  | ("ArrowUp", true, false, _) => highlightPrev()
  | ("ArrowUp", true, true, _) => selectPrev()
  | ("Enter", true, _, _)
  | (" ", true, _, _) =>
    selectCurrent()
  | ("Home", true, _, _) => highlightFirst()
  | ("End", true, _, _) => highlightLast()
  | ("Escape", true, _, _) => hideMenu()
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
