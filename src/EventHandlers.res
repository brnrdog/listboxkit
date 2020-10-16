let onKeyDown = (
  ~menuVisible,
  ~hideMenu,
  ~highlightFirst,
  ~highlightLast,
  ~highlightNext,
  ~highlightPrev,
  ~selectHighlighted,
  ~showMenu,
  event,
) => {
  ReactEvent.Keyboard.preventDefault(event)
  let key = ReactEvent.Keyboard.key(event)

  let selectCurrent = () => {
    selectHighlighted()
    hideMenu()
  }

  switch (key, menuVisible) {
  | ("ArrowDown", false)
  | ("ArrowUp"  , false)
  | ("Enter"    , false)
  | (" "        , false) => showMenu()
  | ("ArrowDown", true)  => highlightNext()
  | ("ArrowUp"  , true)  => highlightPrev()
  | ("Enter"    , true)
  | (" "        , true)  => selectCurrent()
  | ("Home"     , true)  => highlightFirst()
  | ("End"      , true)  => highlightLast()
  | ("Escape"   , true)  => hideMenu()
  | _ => ()
  }
}

let onBlur = (~resetHighlighted, _event) => {
  resetHighlighted()
}

let onFocus = (~selectedIndexes, ~highlightIndex, _event) => {
  selectedIndexes
  -> Belt.Array.reverse
  -> Belt.Array.get(0)
  -> Belt.Option.getWithDefault(0)
  -> highlightIndex
}

let onClick = (~index, ~selectIndex, _event) => selectIndex(index)
