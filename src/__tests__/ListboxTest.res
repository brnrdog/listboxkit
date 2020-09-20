open Jest
open JestDom
open ReactTestingLibrary

type t = {
  key: string
}

module ListboxComponent = {
  let options = ["Red", "Green", "Blue"]

  @react.component
  let make = () => {
    let {highlightedIndex, selectedIndex, getOptionProps}: Listbox.listbox = Listbox.useListbox(
      ~options,
    )

    <ul> 
      {
        options 
        |> Array.mapi((index, option) => {
          let {
            ariaSelected,
            onClick, 
            onKeyDown,
            role,
            tabIndex
          }: Listbox.optionProps = getOptionProps(index)
          
          <li key=option onClick onKeyDown role ariaSelected tabIndex>
            {(highlightedIndex == index ? `* ${option}` : option) |> React.string}
          </li>
        }) 
        |> React.array
      } 
    </ul>
  }
}

let component = <ListboxComponent />

let getOption = (name) => getByRole(
  ~matcher=#Str("option"),
  ~options=DomTestingLibrary.ByRoleQuery.makeOptions(~name, ()),
)

test("renders the option role for 'Red' ", () => {
  component 
  |> render 
  |> getOption("Red") 
  |> expect 
  |> toBeInTheDocument
})

test("renders the option role for 'Green'", () => {
  component 
  |> render 
  |> getOption("Green") 
  |> expect 
  |> toBeInTheDocument
})

test("renders the option role for 'Blue'", () => {
  component 
  |> render 
  |> getOption("Blue") 
  |> expect 
  |> toBeInTheDocument
})

test("sets option aria-selected to true when clicked", () => {
  let component = component |> render
  
  component 
  |> getOption("Red") 
  |> FireEvent.click

  component 
  |> getOption("* Red") 
  |> expect 
  |> toHaveAttribute("aria-selected", ~value="true")
})

test("highlights next option when pressing arrow down ", () => {
  let component = component |> render

  component 
  |> getOption("Red") 
  |> FireEvent.click
  
  component 
  |> getOption("* Red") 
  |> FireEvent.keyDown(~eventInit={"key": "ArrowDown", "code": "ArrowDown"})

  component 
  |> getOption("* Green") 
  |> expect 
  |> toBeInTheDocument
})

test("highlights prev option when pressing arrow up ", () => {
  let component = component |> render

  component 
  |> getOption("Red") 
  |> FireEvent.click
  
  component 
  |> getOption("* Red") 
  |> FireEvent.keyDown(~eventInit={"key": "ArrowUp", "code": "ArrowUp"})

  component 
  |> getOption("* Blue") 
  |> expect 
  |> toBeInTheDocument
})
