// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");
var Listboxkit__ListboxComponent = require("../../../src/Listboxkit__ListboxComponent.bs.js");

function ListboxComponent(Props) {
  return React.createElement(Listboxkit__ListboxComponent.make, {
              className: "listbox",
              optionClassName: "listbox-option",
              activeClassName: "highlighted",
              multiSelect: true,
              options: [
                "Red",
                "Green",
                "Blue"
              ]
            });
}

var make = ListboxComponent;

exports.make = make;
/* react Not a pure module */