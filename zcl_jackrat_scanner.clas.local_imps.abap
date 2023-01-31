class head implementation.
  method constructor.
    me->rule = rule.
    involved_set = new cl_abap_hashmap( ).
    eval_set = new cl_abap_hashmap( ).
  endmethod.
endclass.