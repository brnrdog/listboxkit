type optionProps = {
  role: string;
  'aria-selected': boolean;
  onClick(event: any): void;
};

type listbox = {
  highlightedIndex: number;
  selectedIndexes: Array<number>;
  getOptionProps(index: number): optionProps;
}

export function useListbox<A>(options: Array<A>): listbox;
