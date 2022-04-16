open Jest
open ReactTestingLibrary

include TestUtils

let activeClassName = "highlighted"
let component = (~multiSelect=true, ()) => {
  <div>
    <Listboxkit.ListboxComponent multiSelect options=["Red", "Green", "Blue"] activeClassName />
    <div tabIndex=0>{React.string("Focus out")}</div>
  </div>
}

test("render listbox container", () => {
  component()->render->getListbox->expect->toBeInTheDocument
})

test("renders the options: Red, Green and Blue", () => {
  let component = render(component())

  component->getOption("Red")->expect->toBeInTheDocument->assertAndContinue
  component->getOption("Green")->expect->toBeInTheDocument->assertAndContinue
  component->getOption("Blue")->expect->toBeInTheDocument
})

test("highlights last option when pressing END", () => {
  let component = render(component())

  component->getOption("Red")->FireEvent.pressEnd
  component->getOption("Blue")->expect->toBeHighlighted
})

test("highlights first option when pressing HOME", () => {
  let component = render(component())

  component->getOption("Blue")->FireEvent.pressHome
  component->getOption("Red")->expect->toBeHighlighted
})

test("sets option aria-selected to true when clicked", () => {
  let component = render(component())

  // Nothing should happen when pressing esc.
  component->FireEvent.click
  component->getOption("Red")->FireEvent.click
  component->getOption("Red")->expect |> toHaveAttribute("aria-selected", ~value="true")
})

test("highlights next option when pressing DOWN ", () => {
  let component = render(component())

  let listbox = component->getListbox

  listbox->FireEvent.pressDown
  component->getOption("Green")->expect->toBeHighlighted->assertAndContinue

  listbox->FireEvent.pressDown
  component->getOption("Blue")->expect->toBeHighlighted->assertAndContinue

  listbox->FireEvent.pressDown
  component->getOption("Red")->expect->toBeHighlighted
})

test("highlights previous option when pressing UP ", () => {
  let component = render(component())
  let listbox = component->getListbox

  listbox->FireEvent.pressUp
  component->getOption("Blue")->expect->toBeHighlighted->assertAndContinue

  listbox->FireEvent.pressUp
  component->getOption("Green")->expect->toBeHighlighted->assertAndContinue

  listbox->FireEvent.pressUp
  component->getOption("Red")->expect->toBeHighlighted->assertAndContinue

  listbox->FireEvent.pressUp
  component->getOption("Blue")->expect->toBeHighlighted
})

test("selects and deselects option when pressing SPACE/ENTER", () => {
  let component = render(component(~multiSelect=false, ()))

  component->getOption("Red")->FireEvent.click

  component->getOption("Red")->expect
  |> toHaveAttribute("aria-selected", ~value="true")
  |> assertAndContinue

  component->getListbox->FireEvent.pressEnter

  component->getOption("Red")->expect
  |> toHaveAttribute("aria-selected", ~value="false")
  |> assertAndContinue

  component->getListbox->FireEvent.pressSpace

  component->getOption("Red")->expect |> toHaveAttribute("aria-selected", ~value="true")
})

test("highlights first when focused and no option selected", () => {
  let component = render(component())
  let listbox = component->getListbox

  listbox->FireEvent.click

  component->getOption("Red")->expect->toBeHighlighted
})

Only.test("highlights selected index when focus and option is selected", () => {
  let component = render(component())

  component->getOption("Green")->FireEvent.click

  component->getOption("Green")->expect->toBeHighlighted->assertAndContinue

  component->getListbox->FireEvent.pressDown

  component->getOption("Blue")->expect->toBeHighlighted->assertAndContinue

  FireEvent.tab()

  component->getListbox->FireEvent.click

  component->getOption("Green")->expect->toBeHighlighted
})

test("resets highlighted option when focus out", () => {
  let component = render(component())
  let listbox = component->getListbox

  listbox->FireEvent.pressDown
  listbox->getOption("* Green")->expect->toBeInTheDocument->assertAndContinue

  FireEvent.tab()
  
  listbox->FireEvent.focus
  listbox->getOption("Green")->expect->toBeInTheDocument
})

test("focus out when pressing Tab", () => {
  let component = render(component())

  FireEvent.tab()
  // Highlights first
  component->getOption("* Red")->expect->toBeInTheDocument->assertAndContinue

  FireEvent.tab()

  // Loses focus, highlights none
  component->getOption("Red")->expect->toBeInTheDocument->assertAndContinue

  component->getOption("Green")->expect->toBeInTheDocument->assertAndContinue

  component->getOption("Blue")->expect->toBeInTheDocument
})

test("selects multiple when multiSelect is true", () => {
  let component = render(component(~multiSelect=true, ()))

  FireEvent.tab()

  component->getListbox->FireEvent.pressEnter

  component->getOption("* Red")->expect
  |> toHaveAttribute("aria-selected", ~value="true")
  |> assertAndContinue

  component->getListbox->FireEvent.pressDown

  component->getListbox->FireEvent.pressEnter

  component->getListbox->FireEvent.pressDown

  component->getListbox->FireEvent.pressEnter

  component->getOption("Red")->expect |> toHaveAttribute("aria-selected", ~value="true")
})

test("selects next when pressing arrow down and shift", () => {
  let component = render(component(~multiSelect=true, ()))

  FireEvent.tab()

  component->getListbox->FireEvent.pressDownShift

  component->getOption("* Green")->expect |> toHaveAttribute("aria-selected", ~value="true")
})

test("selects previous when pressing arrow up and shift", () => {
  let component = render(component(~multiSelect=true, ()))

  FireEvent.tab()

  component->getListbox->FireEvent.pressUpShift

  component->getOption("* Blue")->expect |> toHaveAttribute("aria-selected", ~value="true")
})
