open Jest
open DomTestingLibrary

module FireEvent = {
  module Keyboard = {
    let down = "{arrowDown}"
    let downShift = "{shift}{arrowDown}"
    let end = "{end}"
    let enter = "{enter}"
    let esc = "{esc}"
    let home = "{home}"
    let space = "{space}"
    let tab = "{tab}"
    let up = "{arrowUp}"
    let upShift = "{shift}{arrowUp}"
  }

  let pressDown = e => e->UserEvent.type_(Keyboard.down)
  let pressDownShift = e => e->UserEvent.type_(Keyboard.downShift)
  let pressEnd = e => e->UserEvent.type_(Keyboard.end)
  let pressEnter = e => e->UserEvent.type_(Keyboard.enter)
  let pressEsc = e => e->UserEvent.type_(Keyboard.esc)
  let pressHome = e => e->UserEvent.type_(Keyboard.home)
  let pressSpace = e => e->UserEvent.type_(Keyboard.space)
  let pressTab = e => e->UserEvent.type_(Keyboard.tab)
  let pressUp = e => e->UserEvent.type_(Keyboard.up)
  let pressUpShift = e => e->UserEvent.type_(Keyboard.upShift)

  let click = e => e->UserEvent.click
  // Not implemented
  let blur = _ => ()
  // Not implemented
  let focus = _ => ()
  // Not implemented
  let tab = _ => ()
}

let assertAndContinue = _ => ()

let getListbox = getByRole(~matcher=#Str("listbox"))
let getButton = getByRole(~matcher=#Str("button"))

include Jest
include JestDom
