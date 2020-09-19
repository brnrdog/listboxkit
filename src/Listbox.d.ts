type optionProps = {
  role: string;
  ariaSelected: Boolean;
  onClick(event: any): void;
};

type listbox = {
  highlightedIndex: number;
  selectedIndex: number;
  getOptionProps(index: int): optionProps;
}

export function useListbox<A>(options: Array<A>): listbox;
