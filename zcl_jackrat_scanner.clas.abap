class zcl_jackrat_scanner definition public create public.
  public section.
    data input type string.
    data position type i.
    data memoization type ref to cl_abap_map.
    data heads type ref to cl_abap_map.
    data skip_regex type ref to cl_abap_regex.
    data breaks type ref to cl_abap_set.
    methods constructor importing input type string
                                  position type i default 1
                                  skip_whitespace type abap_bool default abap_true.
  private section.
    data skip_whitespace type abap_bool.
    data invocation_stack type ref to lr.

    class-methods get_breaks importing input type string.
    methods match importing regex type ref to cl_abap_regex returning value(result) type string.
    methods skip_whitespace.
    methods is_at_break returning value(result) type abap_bool.
    methods recall importing rule type ref to zcl_jackrat_parser
                             pos type i
                   returning value(result) type ref to memo_entry.
    methods setup_lr importing rule type ref to zcl_jackrat_parser
                              l type ref to lr.
    methods grow_lr importing rule type ref to zcl_jackrat_parser
                              p type i
                              m type ref to memo_entry
                              h type ref to head
                    returning value(result) type ref to zcl_jackrat_node.
    methods lr_answer importing rule type ref to zcl_jackrat_parser
                                pos type i
                                m type ref to memo_entry
                      returning value(result) type ref to zcl_jackrat_node.
    methods apply_rule importing rule type ref to zcl_jackrat_parser
                       returning value(result) type ref to zcl_jackrat_node.
endclass.

class zcl_jackrat_scanner implementation.
  method constructor.
    me->input = input.
    me->position = position.
    me->skip_whitespace = skip_whitespace.
    if skip_whitespace = abap_true.
      me->regex = new cl_abap_regex( '^[\r\n\t ]+' ).
    endif.
    breaks = get_breaks( input ).
  endmethod.

  method get_breaks.
    "data(non_readable) = new cl_abap_regex( '[^\p{L}\p{N}\p{Pc}]' )->find_all( input ).map { it.range.first }.toSet()
    data(previous_word) = abap_false.
    loop at input into data(index).
      data(current_word) = cond abap_bool( when non_readable->contains( index ) = abap_true then abap_false else abap_true ).
      if current_word is not initial or previous_word is not initial.
        add( index ).
      endif.
      previous_word = current_word.
    endloop.
    add( lines( input ) ).
  endmethod.

  method match.
    val matched = regex->find(input.substring(position))
    return if(matched != null){
        position += matched.value.length
        return matched.value
    } else null
  endmethod.

  method skip_whitespace.
  endmethod.
endclass.