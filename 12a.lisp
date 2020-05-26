  $expression__NewScope                            # {expression
    $ekind__NewScope                               # {ekind
      $ekind__SetEnum_object                       # 'object'
    $ekind__Output                                 # }->.ekind
    $object__NewScope                              # {object
      $name__NewScope                              # {name
        $name__GetName                             # GetName
      $name__Output                                # }->.name
      $fieldMap__NewScope                          # {fieldMap
        %map__NewScope                             # [
          $field__NewScope                         # {field
            $name__NewScope                        # {name
              $name__GetName                       # GetName
            $name__Output                          # }->.name
            $__NewScope                            # {
              %map__NewScope                       # [
                $name__NewScope                    # {name
                  $name__GetName                   # GetName
                $name__Output
                $[__AppendFrom_name                # }+
              %map__Output                         # ]
            $__Output                              # }->.parameterList
          $field__Output
          $[__AppendFrom_field                     # }+
        %map__Output                               # ]
      $fieldMap__Output                            # }->.fieldMap
    $object__Output                                # }->.object
  $expression__Output                              # }
                                                   # 
