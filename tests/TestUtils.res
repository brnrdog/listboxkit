open Jest

module FireEvent = {
  open ReactTestingLibrary.UserEvent

  module Keyboard = {
    let down = "{arrowdown}"
    let downShift = "{shift}{arrowDown}"
    let end = "{end}"
    let enter = "{enter}"
    let esc = "{esc}"
    let home = "{home}"
    let space = "{space}"
    let tab = "{Tab}"
    let up = "{arrowUp}"
    let upShift = "{shift}{arrowUp}"
  }

  let pressDown      = e => e->ReactTestingLibrary.UserEvent.type_(Keyboard.down)
  let pressDownShift = e => e->type_(Keyboard.downShift)
  let pressEnd       = e => e->type_(Keyboard.end)
  let pressEnter     = e => e->type_(Keyboard.enter)
  let pressEsc       = e => e->type_(Keyboard.esc)
  let pressHome      = e => e->type_(Keyboard.home)
  let pressSpace     = e => e->type_(Keyboard.space)
  let pressTab       = e => e->type_(Keyboard.tab)
  let pressUp        = e => e->type_(Keyboard.up)
  let pressUpShift   = e => e->type_(Keyboard.upShift)

  let click = e => e->click
  // Not implemented
  let blur = _ => ()
  // Not implemented
  let focus = _ => ()
  // Not implemented
  let tab = UserEvent.tab
}

open ReactTestingLibrary
let getListbox = getByRole(~matcher=#Str("listbox"))
let getButton = getByRole(~matcher=#Str("button"))
let getOption = (e, name) =>
  e->getByRole(~matcher=#Str("option"), ~options=makeByRoleOptions(~name, ()))

include Jest
include JestDom

let assertAndContinue = _ => ()
let toEqual = (a, b) => a |> Expect.toEqual(b)
let toHaveTextContent = (a, b) => a |> JestDom.toHaveTextContent(b)

let toBeHighlighted = expect => expect |> toHaveAttribute("class", ~value="highlighted")
let toBeSelected = expect => expect |> toHaveAttribute("aria-selected", ~value="true")
