open Jest
open ReactTestingLibrary

module FireEvent = {
  include ReactTestingLibrary.FireEvent

  module Keyboard = {
    let down = {"key": "ArrowDown"}
    let downShift = {"key": "ArrowDown", "shiftKey": true}
    let end = {"key": "End"}
    let enter = {"key": "Enter"}
    let esc = {"key": "Esc"}
    let home = {"key": "Home"}
    let space = {"key": " "}
    let tab = {"key": "Tab"}
    let up = {"key": "ArrowUp"}
    let upShift = {"key": "ArrowUp", "shiftKey": true}
  }

  let pressDown = FireEvent.keyDown(~eventInit=Keyboard.down)
  let pressDownShift = FireEvent.keyDown(~eventInit=Keyboard.downShift)
  let pressEnd = FireEvent.keyDown(~eventInit=Keyboard.end)
  let pressEnter = FireEvent.keyDown(~eventInit=Keyboard.enter)
  let pressEsc = FireEvent.keyDown(~eventInit=Keyboard.esc)
  let pressHome = FireEvent.keyDown(~eventInit=Keyboard.home)
  let pressShiftDown = FireEvent.keyDown(~eventInit=Keyboard.downShift)
  let pressSpace = FireEvent.keyDown(~eventInit=Keyboard.space)
  let pressTab = FireEvent.keyDown(~eventInit=Keyboard.tab)
  let pressUp = FireEvent.keyDown(~eventInit=Keyboard.up)
  let pressUpShift = FireEvent.keyDown(~eventInit=Keyboard.upShift)
}

let assertAndContinue = _ => ()

let getListbox = getByRole(~matcher=#Str("listbox"))
let getButton = getByRole(~matcher=#Str("button"))

include Jest
include JestDom
