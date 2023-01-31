class head definition.
  public section.
    data rule type ref to zcl_jackrat_parser.
    data involved_set type ref to cl_abap_hashmap.
    data eval_set type ref to cl_abap_hashmap.
    methods constructor importing rule type ref to zcl_jackrat_parser.
endclass.

class lr definition.
  data seed type ref to zcl_jackrat_node.
  data rule type ref to zcl_jackrat_parser.
  data head type head_type.
  data next type lt_type.
endclass.

class memo_entry definition.
  data lr type ref to lr.
  data ans type ref to zcl_jackrat_node.
  data position type i.
endclass.